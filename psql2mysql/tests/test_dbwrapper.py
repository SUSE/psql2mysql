#
# coding=utf8
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

try:
    import mock
except ImportError:
    from unittest import mock

from collections import namedtuple
import unittest

import psql2mysql


class TestDbWrapper(unittest.TestCase):
    def setUp(self):
        self.db_wrapper = psql2mysql.DbWrapper()

    FakeColumn = namedtuple('FakeColumn', ['name', 'type'])
    FakePrimary = namedtuple('FakePrimary', ['name'])
    FakeTable = namedtuple('FakeTable', ['name', 'columns', 'primary_key'])

    def test_getStringColumns(self):
        table = self.FakeTable("test",
                               [self.FakeColumn("age", "int"),
                                self.FakeColumn("name", "VARCHAR"),
                                self.FakeColumn("noname", " VARCHAR"),
                                self.FakeColumn("description", "TEXT")],
                               None)

        result = self.db_wrapper.getStringColumns(table)
        self.assertEqual(["name", "description"], result)

    @mock.patch('psql2mysql.DbWrapper.getStringColumns')
    @mock.patch('psql2mysql.DbWrapper._query_utf8mb4_rows')
    def test_scanTablefor4ByteUtf8Char(self, mock_utf8mb_rows,
                                       mock_getStringColumns):
        table = self.FakeTable("test", [], [self.FakePrimary("id")])
        mock_getStringColumns.return_value = ["name"]
        mock_utf8mb_rows.return_value = [
            {"name": u"tei\U0010ffffst", "id": 1},
            {"name": "name with Ä", "id": 2},
            {"name": u"ascii name", "id": 3},
            {"name": None, "id": 4}
        ]
        result = self.db_wrapper.scanTablefor4ByteUtf8Char(table)
        wrong_item = result[0]
        self.assertEqual(len(result), 1)
        self.assertEqual("name", wrong_item["column"])
        self.assertEqual("id=1", wrong_item["primary"][0])

    @mock.patch('psql2mysql.DbWrapper.getTextColumns')
    @mock.patch('psql2mysql.DbWrapper._query_long_text_rows')
    def test_scanTableForLongTexts(self, mock_query_long_text_rows,
                                   mock_getTextColumns):
        table = self.FakeTable("test", [], [self.FakePrimary("id")])
        mock_getTextColumns.return_value = ["text"]
        mock_query_long_text_rows.return_value = [
            {"text": u"a"*psql2mysql.MAX_TEXT_LEN, "id": 1},
            {"text": "name with Ä", "id": 2},
            {"text": u"a"*(psql2mysql.MAX_TEXT_LEN+1), "id": 3},
            {"text": None, "id": 4}
        ]
        result = self.db_wrapper.scanTableForLongTexts(table)
        self.assertEqual(len(result), 1)
        wrong_item = result[0]
        self.assertEqual("text", wrong_item["column"])
        self.assertEqual("id=3", wrong_item["primary"][0])


class TestChuckedDbWrapper(TestDbWrapper):
    def setUp(self):
        self.uri = "postgresql://keystone:p@192.168.243.86/keystone"
        self.path = ""
        self.limit = 10
        self.db_wrapper = psql2mysql.ChunkedDBWrapper(self.uri, self.path,
                                                      self.limit)

    def test_find_status(self):
        pass

    def test_close(self):
        pass

    def test_readTableRows(self):
        pass