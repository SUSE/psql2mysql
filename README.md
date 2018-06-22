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

`psql2mysql` currenty provides two subcommands:

* `precheck`

    Runs a couple of checks on the tables of the source database. Currently
    only searches all text columns for characters that are not compatible with
    the "utf8" encoding of MariaDB. Prints out the rows (and affected columns)
    that contains incompatible strings.

* `migrate`

    Runs the acutal migration. Will go through, the database table by table
    and migrate all rows to the target database.

## Examples

To check that it is actually possible to migrate run the `precheck`
subcommand:

```psql2mysql.py --source postgresql://neutron:secret@192.168.1.1/neutron precheck```

To do the actual migraton:
```
    psql2mysql.py \
        --source postgresql://neutron:secret@192.168.1.1/neutron \
        --target mysql+pymysql://neutron:evenmoresecret@192.168.1.2/neutron?charset=utf8 \
        migrate
```

# Testing
`psql2mysql.py` provides a couple of unit tests. To run the tests use:

```nosetests test-psql2mysql.py```
