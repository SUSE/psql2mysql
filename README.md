# Description
`psql2mysql` provides some tooling for migrating data from PostgreSQL to
MariaDB. It was main target for this tool is to migrate the databases of
an [OpenStack](https://www.openstack.org) deployment from PostgreSQL to
MariaDB. But it should work for other databases as well.

The tool itself is based on SQLalchemy and it's builtin type abstraction to
handle some of the differences between both database.

Currently its focused on moving from PostgreSQL to MariaDB. Other MySQL like
databases haven't been tested yet. Neither is the reverse direction of the
migration (MariaDB to PostgreSQL) implemented. Both of these features should
be easy to add however.

# Usage

## Installation

```
mkdir venv
virtualenv venv
. venv/bin/activate
pip install -r requirements.txt
python setup.py install
```

## Prerequisites
* Before using `psql2mysql` for migration, the destination database and all
  its tables need to exist already.
* `psql2mysql` does not do any checks currently if the schema of the target
  and destination database are compatible. In the case of a migration of an
  OpenStack database it is assumed that the respective db_sync tool (e.g.
  `keystone-manage db_sync`) of the OpenStack service has been called before
  running `psql2mysql`.
* The identity provided for the source database needs to have enough
  privileges to read all data and schema in the specified  database.
* Additionally to write access, the identity provided for the target database
  needs privileges to temporary disable constraints and foreign keys for the
  duration of the migration.

## Commands
`psql2mysql` currenty provides two subcommands:

* `precheck`

    Runs a couple of checks on the tables of the source database. Currently
    only searches all text columns for characters that are not compatible with
    the "utf8" encoding of MariaDB. Prints out the rows (and affected columns)
    that contains incompatible strings.

* `migrate`

    Runs the acutal migration. Will go through, the database table by table
    and migrate all rows to the target database.

* `purge-tables`

    Purges all tables in the target database. Tables with names related to
    alembic and SQLalchemy-migrate are skipped and not purged. This subcommand
    can be executed optionally after a failed migration attempt. The `migrate`
    subcommand will also purge all tables in the target database in the same
    way before it starts to copy any data from the source database. But as
    that operation can take a significant amount of time it might make sense
    to run the `purge-tables` subcommand separately before `migrate` in order
    to reduce the overall downtime of the source database.

### Options

* `exclude-deleted`

    When migrating the data from source to target database, exclude soft-deleted
    rows. Set to true by default.

* `batch`

    Process more databases in one run of `psql2mysql`. The argument for this option
    is a path to YML file that lists set of databases with their source and target
    connection strings. The format of YML file is:

    ```
    database1:
      source: source URI for database1
      target: target URI for database1
    database2:
      source: source URI for database2
      ...
    ```

* `chunk-size`

    By default table migrations are broken into chunks, a number of rows at a
    time. The default size is `10000`. This option with change the chunk size.

    Breaking the migration into chunks improves RAM usage and allows the
    migration tool to work with larger databases.

    Setting `chunk-size` to `0` will disable chunking and the migration will
    migrate the whole table in one go. Be warned that this will use more RAM.

## Examples

To check that it is actually possible to migrate run the `precheck`
subcommand:

```psql2mysql --source postgresql://neutron:secret@192.168.1.1/neutron precheck```

To check all databases in the batch file:

```psql2mysql --batch databases.yml precheck```


To do the actual migraton:
```
    psql2mysql \
        --source postgresql://neutron:secret@192.168.1.1/neutron \
        --target mysql+pymysql://neutron:evenmoresecret@192.168.1.2/neutron?charset=utf8 \
        migrate
```

To migrate all databases in the batch file:

```psql2mysql --batch databases.yml migrate```


# Testing
`psql2mysql` provides a test suite. To run the tests use:

```nosetests```
