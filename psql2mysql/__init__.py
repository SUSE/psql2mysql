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

import re
import six
import sys
import warnings
import yaml
from oslo_config import cfg
from oslo_log import log as logging
from prettytable import PrettyTable
from rfc3986 import uri_reference
from sqlalchemy import create_engine, MetaData, or_, text, types
from sqlalchemy import exc as sa_exc
from psql2mysql.datetime2decimal import PreciseTimestamp

LOG = logging.getLogger(__name__)

MAX_TEXT_LEN = 65536

regex = re.compile(
    six.u(r'[\U00010000-\U0010ffff]')
)

typeConversions = [
    {"src": types.DateTime,
     "dest": types.DECIMAL,
     "decorator": PreciseTimestamp}
]


def lookupTypeDecorator(srcType, destType):
    for conv in typeConversions:
        if isinstance(srcType, conv["src"]) and isinstance(destType,
                                                           conv["dest"]):
            return conv["decorator"]
    return None


class DbWrapper(object):
    def __init__(self, uri="", chunk_size=0):
        self.uri = uri
        self.chunk_size = chunk_size

    def connect(self):
        self.engine = create_engine(self.uri)
        self.connection = self.engine.connect()

    def getSortedTables(self):
        metadata = MetaData(bind=self.engine)
        with warnings.catch_warnings():
            warnings.simplefilter("ignore", category=sa_exc.SAWarning)
            metadata.reflect()
        return metadata.sorted_tables

    def getTables(self):
        metadata = MetaData(bind=self.engine)
        with warnings.catch_warnings():
            warnings.simplefilter("ignore", category=sa_exc.SAWarning)
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
        return self.engine.execute(self._exclude_deleted(table,
                                                         table.select()))

    # FIXME move this to a MariaDB specific class?
    def disable_constraints(self):
        self.connection.execute(
            "SET SESSION check_constraint_checks='OFF'"
        )
        self.connection.execute(
            "SET SESSION foreign_key_checks='OFF'"
        )

    def writeTableRows(self, table, rows):
        if self.chunk_size > 0:
            chunk = rows.fetchmany(self.chunk_size)
            while chunk:
                self.connection.execute(table.insert(), chunk)
                chunk = rows.fetchmany(self.chunk_size)
        else:
            self.connection.execute(
                table.insert(),
                rows.fetchall()
            )

    def clearTable(self, table):
        LOG.debug("Purging table: %s", table.name)
        if self.chunk_size > 0:
            # DELETE ... LIMIT is MySQL specific and there is no way to
            # express it in SQLalchemy other than using a raw query.
            query = "DELETE FROM `%s` LIMIT %d" % (table.name, self.chunk_size)
            res = self.connection.execute(query)
            while res.rowcount:
                res = self.connection.execute(query)
        else:
            self.connection.execute(table.delete())


class SourceDatabaseEmpty(Exception):
    pass


class TargetDatabaseEmpty(Exception):
    pass


class Psql2MysqlRuntimeError(RuntimeError):
    pass


class DbDataMigrator(object):
    def __init__(self, config, source, target, chunk_size=None):
        self.cfg = config
        self.src_uri = source if source else cfg.CONF.source
        self.target_uri = target if target else cfg.CONF.target
        self.chunk_size = chunk_size if chunk_size else cfg.CONF.chunk_size
        self._src_db = None
        self._target_db = None

    @property
    def src_db(self):
        if not self._src_db:
            self._src_db = DbWrapper(self.src_uri, self.chunk_size)
            self._src_db.connect()
        return self._src_db

    @property
    def target_db(self):
        if not self._target_db:
            self._target_db = DbWrapper(self.target_uri, self.chunk_size)
            self._target_db.connect()
        return self._target_db

    def purgeTables(self):
        target_tables = self.target_db.getTables()
        if not target_tables:
            return

        # disable constraints on the MariaDB side for the duration of
        # the migration
        LOG.info("Disabling constraints on target database")
        self.target_db.disable_constraints()

        for table in self.target_db.getSortedTables():
            if (table.name == "migrate_version" or
                    table.name.startswith("alembic_")):
                continue
            self.target_db.clearTable(table)

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

        for table in source_tables:
            LOG.info("Migrating table: '%s'" % table.name)
            if table.name not in target_tables:
                raise Psql2MysqlRuntimeError(
                    "Table '%s' does not exist in target database" %
                    table.name)

            self.setupTypeDecorators(table, target_tables[table.name])

            # skip the schema migration related tables
            # FIXME: Should we put this into a config setting
            # (e.g. --skiptables?)
            if (table.name == "migrate_version" or
                    table.name.startswith("alembic_")):
                continue

            result = self.src_db.readTableRows(table)
            if result.returns_rows and result.rowcount > 0:
                LOG.info("Rowcount %s" % result.rowcount)
                # FIXME: Allow to process this in batches instead one possibly
                # huge transcation?
                self.target_db.writeTableRows(target_tables[table.name],
                                              result)
            else:
                LOG.debug("Table '%s' is empty" % table.name)

    def setupTypeDecorators(self, srcTable, targetTable):
        """
        Compare the types of all columns in srcTable and targetTable. If
        they do not match, try to figure out if we have a TypeDecorator
        configured that could be used for converting the values. If there
        is one, change the type of the targetTable's columns accordingly.

        FIXME: Currently we ignore case where on TypeDecorator is found
        optimistically assuming that SQLalchemy will do the right thing,
        e.g. as for converting from Boolean (PostgreSQL) to TinyInt (MySQL)
        ideally we should makes this more explicit by adding a proper precheck
        and defining supported conversion and raising Errors/Warnings if a non
        supported combination of Types occurs)
        """
        srcColumns = srcTable.columns

        for col in srcColumns:
            targetCol = targetTable.c[col.name]
            if not isinstance(targetCol.type, col.type.__class__):
                decorator = lookupTypeDecorator(col.type, targetCol.type)
                if decorator:
                    LOG.info("Converting values in column '%s' from type "
                             "'%s' to type '%s' using TypeDecorator '%s'",
                             col.name, col.type, targetCol.type,
                             decorator.__name__)
                    targetTable.c[targetCol.name].type = decorator


def add_subcommands(subparsers):
    parser = subparsers.add_parser('precheck',
                                   help='Run prechecks on the PostgreSQL '
                                        'database')
    parser.set_defaults(func=do_prechecks)

    parser = subparsers.add_parser(
        'migrate',
        help='Migrate data from PostgreSQL to MariaDB')
    parser.set_defaults(func=do_migration)

    parser = subparsers.add_parser(
        'purge-tables',
        help='Purge all data from the tables in the target database')
    parser.set_defaults(func=do_purge_tables)


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
            print("4 Byte UTF8 characters found in the source database.")
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
            print("Too long text values found in the source database.")
            prechecks_ok = False

    if prechecks_ok:
        print("Success. No errors found during prechecks.")
    else:
        raise Psql2MysqlRuntimeError(
            "Errors were found during prechecks. Please address the reported "
            "issues manually and try again."
        )


def do_migration(config, source, target):
    migrator = DbDataMigrator(config, source, target)
    try:
        migrator.purgeTables()
        migrator.migrate()
    except SourceDatabaseEmpty:
        print("The source database doesn't contain any Tables. "
              "Nothing to migrate.")
    except TargetDatabaseEmpty:
        print("Error: The target database doesn't contain any Tables. Make "
              "sure to create the Schema in the target database before "
              "starting the migration.")
        sys.exit(1)


def do_purge_tables(config, source, target):
    migrator = DbDataMigrator(config, source, target)
    migrator.purgeTables()


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
                         'True by default.'),
        cfg.IntOpt('chunk-size',
                   default=10000,
                   min=0,
                   help='Number of records to move per chunk. Set to 0 to '
                        'disable, default is 10,000.')
    ]

    cfg.CONF.register_cli_opts(cli_opts)
    logging.register_options(cfg.CONF)
    logging.set_defaults()

    # read config and initialize logging
    cfg.CONF(project='psql2mysql')
#    cfg.CONF.set_override("use_stderr", True)

    logging.setup(cfg.CONF, 'psql2mysql')

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
                for db_name, db in yaml.load(f).iteritems():
                    print('Processing database "%s"... ' % db_name)
                    check_source_schema(db['source'])
                    if db['target']:
                        check_target_schema(db['target'])
                    cfg.CONF.command.func(cfg, db['source'], db['target'])

        except Psql2MysqlRuntimeError as e:
            print(e, file=sys.stderr)
            sys.exit(1)
        except IOError:
            print('Batch file "%s" does not exist or cannot be read'
                  % cfg.CONF.batch)
            sys.exit(2)

        print("Batch processing done.")
        sys.exit(0)

    if not cfg.CONF.source:
        print("Source database was not specified.")
        sys.exit(1)

    check_source_schema(cfg.CONF.source)

    if cfg.CONF.target:
        check_target_schema(cfg.CONF.target)

    try:
        cfg.CONF.command.func(cfg, cfg.CONF.source, cfg.CONF.target)
    except Psql2MysqlRuntimeError as e:
        print(e, file=sys.stderr)
        sys.exit(1)
