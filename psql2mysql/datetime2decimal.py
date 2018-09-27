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

import calendar
import datetime
import decimal
from sqlalchemy import DateTime, types

'''
This code (dt_to_decimal, decimal_to_dt and class PreciseTimestam) is taken
from Ceilometer (http://git.openstack.org/cgit/openstack/ceilometer/) as it
uses a TypeDecorator to implement a custome high precision timestamps Type
based on the "Decimal" type for MySQL. We need to convert PostgreSQL's
timestamps to that format when migrating the ceilometer databases.
'''


def dt_to_decimal(utc):
    """Datetime to Decimal.

    Some databases don't store microseconds in datetime
    so we always store as Decimal unixtime.
    """
    if utc is None:
        return None

    decimal.getcontext().prec = 30
    return (decimal.Decimal(str(calendar.timegm(utc.utctimetuple()))) +
            (decimal.Decimal(str(utc.microsecond)) /
            decimal.Decimal("1000000.0")))


def decimal_to_dt(dec):
    """Return a datetime from Decimal unixtime format."""
    if dec is None:
        return None

    integer = int(dec)
    micro = (dec - decimal.Decimal(integer)) * decimal.Decimal(1000**2)
    daittyme = datetime.datetime.utcfromtimestamp(integer)
    return daittyme.replace(microsecond=int(round(micro)))


class PreciseTimestamp(types.TypeDecorator):
    """Represents a timestamp precise to the microsecond."""

    impl = DateTime

    def load_dialect_impl(self, dialect):
        if dialect.name == 'mysql':
            return dialect.type_descriptor(
                types.DECIMAL(precision=20, scale=6, asdecimal=True)
            )
        return self.impl

    @staticmethod
    def process_bind_param(value, dialect):
        if value is None:
            return value
        elif dialect.name == 'mysql':
            return dt_to_decimal(value)
        return value

    @staticmethod
    def process_result_value(value, dialect):
        if value is None:
            return value
        elif dialect.name == 'mysql':
            return decimal_to_dt(value)
        return value
