#!/bin/bash

set -ev

# Precheck

./psql2mysql.py --source postgresql://neutron:secret@localhost/neutron precheck

# Migrate 

./psql2mysql.py \
    --source postgresql://neutron:secret@localhost/neutron \
    --target mysql+pymysql://neutron:evenmoresecret@localhost/neutron?charset=utf8 \
    migrate

# Verify migration was succesful

mysqldump -u neutron -pevenmoresecret neutron > neutron_migrated.sql

if ! cmp neutron.sql neutron_migrated.sql
then
  echo "Database Migration Failed"
  exit 1
fi

