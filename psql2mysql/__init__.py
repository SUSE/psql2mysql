# (c) Copyright 2018, SUSE LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
from __future__ import print_function

import json
import os
import re
import six
import sys
import yaml
from datetime import datetime
from oslo_config import cfg
from oslo_log import log as logging
from prettytable import PrettyTable
from rfc3986 import uri_reference
from six.moves.urllib.parse import urlparse
from sqlalchemy import create_engine, MetaData, or_, text, types

LOG = logging.getLogger(__name__)

MAX_TEXT_LEN = 65536

regex = re.compile(
    six.u(r'[\U00010000-\U0010ffff]')
)


class DbWrapper(object):
    def __init__(self, uri=""):
        self.uri = uri

    def connect(self):
        self.engine = create_engine(self.uri)
        self.connection = self.engine.connect()

    def getSortedTables(self):
        metadata = MetaData(bind=self.engine)
        metadata.reflect()
        return metadata.sorted_tables

    def getTables(self):
        metadata = MetaData(bind=self.engine)
        metadata.reflect()
        return metadata.tables

    # adapt given query so it excludes deleted items
    def _exclude_deleted(self, table, query):
        if not cfg.CONF.exclude_deleted:
            return query
        if "deleted" not in table.columns:
            return query
        if isinstance(table.columns["deleted"].type, types.INTEGER):
            return query.where(table.c.deleted == 0)
        if isinstance(table.columns["deleted"].type, types.VARCHAR):
            return query.where(table.c.deleted == 'False')
        return query.where(table.c.deleted.is_(False))

    def getTextColumns(self, table):
        columns = table.columns
        return [c.name for c in columns if str(c.type) == 'TEXT']

    def _query_long_text_rows(self, table, textColumns):
        filters = [
            text("length(\"%s\") > %i" % (x, MAX_TEXT_LEN))
            for x in textColumns
        ]
        q = table.select().where(or_(f for f in filters))
        rows = q.execute()
        return rows

    def scanTableForLongTexts(self, table):
        textColumns = self.getTextColumns(table)
        if not textColumns:
            return []
        LOG.debug("Scanning Table %s (columns: %s) for too long TEXT values ",
                  table.name, textColumns)
        rows = self._query_long_text_rows(table, textColumns)
        long_values = []
        primary_keys = []
        if table.primary_key:
            primary_keys = list(table.primary_key)
        for row in rows:
            for col in textColumns:
                if not isinstance(row[col], six.string_types):
                    continue
                if len(row[col]) > MAX_TEXT_LEN:
                    long_values.append({
                      "column": col,
                      "primary": ["%s=%s" % (k.name, row[k.name])
                                  for k in primary_keys]
                    })
        return long_values

    def getStringColumns(self, table):
        columns = table.columns
        textColumns = [
            c.name for c in columns if str(c.type).startswith('VARCHAR') or
            str(c.type) == 'TEXT'
        ]
        return textColumns

    def _query_utf8mb4_rows(self, table, stringColumns):
        # Need a raw text filter here as SQLalchemy doesn't seem to provide
        # abstractions for regex
        filters = [
            text("\"%s\" ~ '[\\x10000-\\x10ffff]'" % x) for x in stringColumns
        ]
        q = table.select().where(or_(f for f in filters))
        result = self._exclude_deleted(table, q).execute()
        return result

    def scanTablefor4ByteUtf8Char(self, table):
        stringColumns = self.getStringColumns(table)
        LOG.debug("Scanning Table %s (columns: %s) for problematic UTF8 "
                  "characters", table.name, stringColumns)
        rows = self._query_utf8mb4_rows(table, stringColumns)
        incompatible = []
        primary_keys = []
        if table.primary_key:
            primary_keys = list(table.primary_key)
        for row in rows:
            for col in stringColumns:
                if not isinstance(row[col], six.string_types):
                    continue
                if regex.search(row[col]):
                    incompatible.append({
                      "column": col,
                      "value": row[col],
                      "primary": ["%s=%s" % (k.name, row[k.name])
                                  for k in primary_keys]
                    })
        return incompatible

    def readTableRows(self, table):
        """

        :param table: Database table object to read from.
        :return: A result tuple in the form of:
                (resturns_rows, rowcount, chunked, row iterator)
        """
        chunked = False
        rows = self.engine.execute(self._exclude_deleted(table,
                                                         table.select()))

        return rows.returns_rows, rows.rowcount, chunked, iter(rows)

    # FIXME move this to a MariaDB specific class?
    def disable_constraints(self):
        self.connection.execute(
            "SET SESSION check_constraint_checks='OFF'"
        )
        self.connection.execute(
            "SET SESSION foreign_key_checks='OFF'"
        )

    def writeTableRows(self, table, rows):
        # FIXME: Allow to process this in batches instead one possibly
        # huge transcation?
        self.connection.execute(
            table.insert(),
            *rows
        )

    def clearTable(self, table):
        self.connection.execute(table.delete())

    def close(self):
        pass


class ChunkedDBWrapper(DbWrapper):

    def __init__(self, uri="", path='/tmp/psql2mysql/', limit=10000):
        super(ChunkedDBWrapper, self).__init__(uri)

        self.limit = limit
        res = urlparse(uri)
        self.status_file = "{}-{}.json".format(res.hostname, res.path[1:])
        self.status_path = os.path.join(path, self.status_file)

        if not os.path.exists(path):
            os.makedirs(path)
        try:
            self.status = json.load(open(self.status_path)) or {}
        except IOError:
            self.status = {}

    def _find_status(self, table):
        primary_key = list(table.primary_key) if table.primary_key else []

        if not primary_key or len(primary_key) > 1:
            return None

        primary_key = primary_key.pop()
        status = {}

        if isinstance(table.columns[primary_key.name].type, types.VARCHAR):
            # using uuid, we we will filter by created_at if it exists or
            # fall back to full table migration
            # NOTE: sqlalchemy's Columns cant be boolean compared, so need to
            # use 'is not None' here.
            if table.columns.get('created_at') is not None:
                status['col'] = 'created_at'
            else:
                return None
        elif isinstance(table.columns[primary_key.name].type, types.INTEGER):
            # Assuming auto-increment id.
            status['col'] = primary_key.name
        else:
            return None
        return status

    def readTableRows(self, table):
        chunked = True
        # sqlalchemy table and columns can not do boolean checks, so:
        #    self.status.get(table, self._find_status(table))
        # isn't possible here
        status = self.status.get(table.name)
        if status is None:
            status = self._find_status(table)

        if not status:
            chunked = False
            select = table.select()
        else:
            if 'mark' in status:
                select = table.select().where(
                    table.columns[status['col']] > status['mark']).\
                    order_by(table.columns[status['col']]).limit(self.limit)
            else:
                select = table.select().\
                    order_by(table.columns[status['col']]).limit(self.limit)

        self.status[table.name] = status
        rows = self.engine.execute(self._exclude_deleted(table, select))

        def row_iter():
            for row in rows.fetchall():
                if status:
                    if isinstance(row[status['col']], datetime):
                        self.status[table.name]['mark'] = \
                            row[status['col']].isoformat()
                    else:
                        self.status[table.name]['mark'] = row[status['col']]
                yield row

        return rows.returns_rows, rows.rowcount, chunked, row_iter()

    def close(self):
        try:
            with open(self.status_path, 'w') as writer:
                json.dump(self.status, writer)
        except IOError as err:
            # TODO: do something here.
            raise StatusSaveError(err.message, self.status_path)


class SourceDatabaseEmpty(Exception):
    pass


class TargetDatabaseEmpty(Exception):
    pass


class StatusSaveError(Exception):
    def __init__(self, message, status_path):
        self.message = message
        self.status_path = status_path


class DbDataMigrator(object):
    def __init__(self, config, source, target):
        self.cfg = config
        self.src_uri = source if source else cfg.CONF.source
        self.target_uri = target if target else cfg.CONF.target

    def setup(self):
        if cfg.CONF.command.chunked:
            self.src_db = ChunkedDBWrapper(self.src_uri,
                                           cfg.CONF.command.status_dir,
                                           cfg.CONF.command.chunk_size)
        else:
            self.src_db = DbWrapper(self.src_uri)
        self.src_db.connect()

        self.target_db = DbWrapper(self.target_uri)
        self.target_db.connect()

    def migrate(self):
        source_tables = self.src_db.getSortedTables()
        target_tables = self.target_db.getTables()

        if not source_tables:
            raise SourceDatabaseEmpty()

        if not target_tables:
            raise TargetDatabaseEmpty()

        # disable constraints on the MariaDB side for the duration of
        # the migration
        LOG.info("Disabling constraints on target DB for the migration")
        self.target_db.disable_constraints()

        # FIXME: Make this optional
        for table in self.target_db.getSortedTables():
            if (table.name == "migrate_version" or
                    table.name.startswith("alembic_")):
                continue
            self.target_db.clearTable(table)

        try:
            for table in source_tables:
                LOG.info("Migrating table: '%s'" % table.name)

                # skip the schema migration related tables
                # FIXME: Should we put this into a config setting
                # (e.g. --skiptables?)
                if (table.name == "migrate_version" or
                        table.name.startswith("alembic_")):
                    continue

                if table.name not in target_tables:
                    raise Exception(
                        "Table '%s' does not exist in target database" %
                        table.name)

                returns_rows, rowcount, chunked, rows = \
                    self.src_db.readTableRows(table)
                if not returns_rows or rowcount == 0:
                    LOG.debug("Table '%s' is empty" % table.name)

                while returns_rows and rowcount > 0:
                    if chunked:
                        LOG.info("Using chunked table migration")
                        LOG.info("Migrating chuck with rowcount %s" % rowcount)
                    else:
                        LOG.info("Using full table migration")
                        LOG.info("Rowcount %s" % rowcount)
                    # FIXME: Allow to process this in batches instead one
                    # possibly huge transcation?
                    self.target_db.writeTableRows(target_tables[table.name],
                                                  rows)
                    if not chunked:
                        break
                    returns_rows, rowcount, chunked, rows = \
                        self.src_db.readTableRows(table)
        finally:
            # always attempt to close, as if we're doing a chunked migration
            # we want the status files written.
            try:
                self.src_db.close()
                self.target_db.close()
            except StatusSaveError as err:
                LOG.warning("Failed to save current migration status to %s"
                            % err.status_path)


def add_subcommands(subparsers):
    parser = subparsers.add_parser('precheck',
                                   help='Run prechecks on the PostgreSQL '
                                        'database')
    parser.add_argument("mariadb-utf8",
                        action='store_true',
                        default=True,
                        help='Check all string columns for incompatibilities '
                             'with mysql\'s utf8 encoding.')
    parser.set_defaults(func=do_prechecks)

    parser = subparsers.add_parser(
        'migrate',
        help='Migrate data from PostgreSQL to MariaDB')
    parser.add_argument("--chunked",
                        action='store_true',
                        default=False,
                        help='split table migrations into chucks of records '
                             'at a time.')
    parser.add_argument("--chunk-size",
                        default=10000,
                        help='Number of records to move per chunk.')
    parser.add_argument("--status-dir",
                        default='/tmp/psql2mysql/',
                        help='Directory location to store source database '
                             'migration state.')
    parser.set_defaults(func=do_migration)


def do_prechecks(config, source, target):
    src_uri = source if source else cfg.CONF.source
    db = DbWrapper(src_uri)
    db.connect()
    tables = db.getSortedTables()
    prechecks_ok = True
    for table in tables:
        incompatibles = db.scanTablefor4ByteUtf8Char(table)
        if incompatibles:
            print("Table '%s' contains 4 Byte UTF8 characters which are "
                  "incompatible with the 'utf8' encoding used by MariaDB" %
                  table.name)
            print("The following rows are affected:")

            output_table = PrettyTable()
            output_table.field_names = [
                "Primary Key",
                "Affected Column",
                "Value"
            ]

            for item in incompatibles:
                output_table.add_row([', '.join(item["primary"]),
                                      item['column'],
                                      item['value']])
            print(output_table)
            print("Error during prechecks. "
                  "4 Byte UTF8 characters found in the source database.")
            prechecks_ok = False

        long_values = db.scanTableForLongTexts(table)
        if long_values:
            print("Table '%s' contains TEXT values that are more than %s "
                  "characters long. This is incompatible with MariaDB setup.",
                  table.name, MAX_TEXT_LEN)
            print("The following rows are affected:")

            output_table = PrettyTable()
            output_table.field_names = [
                "Primary Key",
                "Affected Column"
            ]

            for item in long_values:
                output_table.add_row([', '.join(item["primary"]),
                                      item['column']])
            print(output_table)
            print("Error during prechecks. "
                  "Too long text values found in the source database.")
            prechecks_ok = False

    if prechecks_ok:
        print("Success. No errors found during prechecks.")


def do_migration(config, source, target):
    migrator = DbDataMigrator(config, source, target)
    migrator.setup()
    try:
        migrator.migrate()
    except SourceDatabaseEmpty:
        print("The source database doesn't contain any Tables. "
              "Nothing to migrate.")
    except TargetDatabaseEmpty:
        print("Error: The target database doesn't contain any Tables. Make "
              "sure to create the Schema in the target database before "
              "starting the migration.")
        sys.exit(1)


# restrict the source database to postgresql for now
def check_source_schema(source):
    if uri_reference(source).scheme != "postgresql":
        print('Error: Only "postgresql" is supported as the source database '
              'currently', file=sys.stderr)
        sys.exit(1)


# restrict the target database to mysql+pymsql
def check_target_schema(target):

    uri = uri_reference(target)
    if uri.scheme != "mysql+pymysql":
        print('Error: Only "mysql" with the "pymysql" driver is supported '
              'as the target database currently',
              file=sys.stderr)
        sys.exit(1)
    if uri.query is None or "charset=utf8" not in uri.query:
        print('Error: The target connection is missing the "charset=utf8" '
              'parameter.', file=sys.stderr)
        sys.exit(1)


def main():
    # FIXME: Split these up into separate components?
    #   host, port, username, password, database
    cli_opts = [
        cfg.SubCommandOpt('command',
                          title="Commands",
                          help="Available commands",
                          handler=add_subcommands),
        cfg.URIOpt('source',
                   required=False,
                   help='connection URL to the src DB server'),
        cfg.URIOpt('target',
                   required=False,
                   help='connection URL to the target server'),
        cfg.StrOpt('batch',
                   required=False,
                   help='YAML file containing connection URLs'),
        cfg.BoolOpt('exclude-deleted',
                    default=True,
                    help='Exclude table rows marked as deleted. '
                         'True by default.')
    ]

    cfg.CONF.register_cli_opts(cli_opts)
    logging.register_options(cfg.CONF)
    logging.set_defaults()

    # read config and initialize logging
    cfg.CONF(project='pg2my')
#    cfg.CONF.set_override("use_stderr", True)

    logging.setup(cfg.CONF, 'pg2my')

    # We expect batch file with this syntax:
    #
    # keystone:
    #   source: postgresql://keystone:p@192.168.243.86/keystone
    #   target: mysql+pymysql://keystone:p@192.168.243.87/keystone?charset=utf8
    # cinder:
    #   source: postgresql://cinder:idRll2gJPodv@192.168.243.86/cinder
    #   target:
    if cfg.CONF.batch:
        try:
            with open(cfg.CONF.batch, 'r') as f:
                for db_name, db in yaml.load(f).items():
                    print('Processing database "%s"... ' % db_name)
                    check_source_schema(db['source'])
                    if db['target']:
                        check_target_schema(db['target'])
                    cfg.CONF.command.func(cfg, db['source'], db['target'])

        except IOError:
            print('Batch file "%s" does not exist or cannot be read'
                  % cfg.CONF.batch)
            sys.exit(2)

        print("Batch processing done.")
        sys.exit(0)

    check_source_schema(cfg.CONF.source)

    if cfg.CONF.target:
        check_target_schema(cfg.CONF.target)

    cfg.CONF.command.func(cfg, cfg.CONF.source, cfg.CONF.target)
