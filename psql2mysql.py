#!/usr/bin/python2
#
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

import re
import six
from oslo_config import cfg
from oslo_log import log as logging
from prettytable import PrettyTable
from sqlalchemy import create_engine, MetaData, or_, text, types


LOG = logging.getLogger(__name__)


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
        if not "deleted" in table.columns:
            return query
        if isinstance(table.columns["deleted"].type, types.INTEGER):
            return query.where(table.c.deleted == 0)
        if isinstance(table.columns["deleted"].type, types.VARCHAR):
            return query.where(table.c.deleted == 'False')
        return query.where(table.c.deleted == False)

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
        result = _exclude_deleted(table, q).execute()
        return result

    def scanTablefor4ByteUtf8Char(self, table):
        stringColumns = self.getStringColumns(table)
        LOG.debug("Scanning Table %s (columns: %s) for problematic UTF8 "
                 "characters", table.name, stringColumns)
        rows = self._query_utf8mb4_rows(table, stringColumns)
        incompatible = []
        primary_keys = []
        if not table.primary_key == None:
          primary_keys = list(table.primary_key)
        for row in rows:
            for col in stringColumns:
                if not isinstance(row[col], six.string_types):
                    continue
                if regex.search(row[col]):
                    incompatible.append({
                      "column": col,
                      "value": row[col],
                      "primary": ["%s=%s" % (k.name, row[k.name]) for k in primary_keys]
                    })
        return incompatible

    def readTableRows(self, table):
        return self.engine.execute(self._exclude_deleted(table, table.select()))

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
            rows.fetchall()
        )

    def clearTable(self,table):
        self.connection.execute(table.delete())

class DbDataMigrator(object):
    def __init__(self, config):
        self.cfg = config

    def setup(self):
        self.src_db = DbWrapper(cfg.CONF.source)
        self.src_db.connect()

        self.target_db = DbWrapper(cfg.CONF.target)
        self.target_db.connect()

    def migrate(self):
        source_tables = self.src_db.getSortedTables()
        target_tables = self.target_db.getTables()

        if not source_tables:
            raise Exception("Source Database doesn't contain any tables")

        if not target_tables:
            raise Exception("Target Database doesn't contain any tables")

        # disable constraints on the MariaDB side for the duration of
        # the migration
        LOG.info("Disabling constraints on target DB for the migration")
        self.target_db.disable_constraints()

        # FIXME: Make this optional
        for table in self.target_db.getSortedTables():
            if ( table.name == "migrate_version" or
                 table.name.startswith("alembic_")):
                continue
            self.target_db.clearTable(table)

        for table in source_tables:
            LOG.info("Migrating table: '%s'" % table.name)
            if table.name not in target_tables:
                raise Exception("Table '%s' does not exist in target database" %
                                table.name)

            # skip the schema migration related tables
            # FIXME: Should we put this into a config setting
            # (e.g. --skiptables?)
            if ( table.name == "migrate_version" or
                 table.name.startswith("alembic_")):
                continue

            result = self.src_db.readTableRows(table)
            if result.returns_rows and result.rowcount > 0:
                LOG.info("Rowcount %s" % result.rowcount)
                # FIXME: Allow to process this in batches instead one possibly
                # huge transcation?
                self.target_db.writeTableRows(target_tables[table.name], result)
            else:
                LOG.debug("Table '%s' is empty" % table.name)


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
    parser.set_defaults(func=do_migration)

def do_prechecks(config):
    db = DbWrapper(cfg.CONF.source)
    db.connect()
    tables = db.getSortedTables()
    for table in tables:
        incompatibles = db.scanTablefor4ByteUtf8Char(table)
        if incompatibles:
            print("Table '%s' contains 4 Byte UTF8 characters which are "
                  "incompatible with the 'utf8' encoding used by MariaDB" %
                  table.name
            )
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
            raise Exception("4 Byte UTF8 characters found in the source database.")
        ## FIXME add check for overly long (>64k) Text columns here

def do_migration(config):
    migrator = DbDataMigrator(config)
    migrator.setup()
    migrator.migrate()

if __name__ == '__main__':
    # FIXME: Split these up into separate components?
    #   host, port, username, password, database
    cli_opts = [
        cfg.SubCommandOpt('command',
                          title="Commands",
                          help="Available commands",
                          handler=add_subcommands),
        cfg.StrOpt('source',
                   required=True,
                   help='connection URL to the src DB server'),
        cfg.StrOpt('target',
                   required=False,
                   help='connection URL to the target server'),
        cfg.BoolOpt('exclude-deleted',
                    default=True,
                    help='Exclude table columns marked as deleted. True by default.')
    ]

    cfg.CONF.register_cli_opts(cli_opts)
    logging.register_options(cfg.CONF)
    logging.set_defaults()

    # read config and initialize logging
    cfg.CONF(project='pg2my')
#    cfg.CONF.set_override("use_stderr", True)

    logging.setup(cfg.CONF, 'pg2my')
    print(cfg.CONF.command.name)
    cfg.CONF.command.func(cfg)
