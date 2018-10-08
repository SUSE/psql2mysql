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

    def test_chunked_write_table_rows(self):
        mock_table = mock.MagicMock()
        mock_connection = mock.MagicMock()
        mock_rows = mock.MagicMock()
        mock_rows.fetchmany.side_effect = [['one response'],
                                           ['second response'], []]

        self.db_wrapper.chunk_size = 1
        self.db_wrapper.connection = mock_connection
        self.db_wrapper.writeTableRows(mock_table, mock_rows)

        self.assertEqual(mock_rows.fetchmany.call_count, 3)
        self.assertFalse(mock_rows.fetchall.called)
        self.assertEqual(mock_connection.execute.call_count, 2)

    def test_full_table_write_table_rows(self):
        mock_table = mock.MagicMock()
        mock_connection = mock.MagicMock()
        mock_rows = mock.MagicMock()
        mock_rows.fetchall.side_effect = [['one response'], ]
        self.db_wrapper.connection = mock_connection
        self.db_wrapper.chunk_size = 0

        self.db_wrapper.writeTableRows(mock_table, mock_rows)

        self.assertTrue(mock_rows.fetchall.called)
        self.assertFalse(mock_rows.fetchmany.called)
        self.assertTrue(mock_connection.execute.called)

    def test_chunked_clear_table(self):
        mock_table = mock.MagicMock()
        mock_table.name = "Table"
        mock_connection = mock.MagicMock()
        Result = namedtuple("Result", ["rowcount"])
        mock_connection.execute.side_effect = [
            Result(10), Result(5), Result(0)
        ]

        self.db_wrapper.chunk_size = 10
        self.db_wrapper.connection = mock_connection
        self.db_wrapper.clearTable(mock_table)

        self.assertFalse(mock_table.delete.called)
        self.assertEqual(mock_connection.execute.call_count, 3)
        mock_connection.execute.assert_called_with(
            "DELETE FROM `%s` LIMIT %d" % (mock_table.name,
                                           self.db_wrapper.chunk_size))

    def test_full_clear_table(self):
        mock_table = mock.MagicMock()
        mock_connection = mock.MagicMock()

        self.db_wrapper.connection = mock_connection
        self.db_wrapper.chunk_size = 0

        self.db_wrapper.clearTable(mock_table)

        self.assertTrue(mock_table.delete.called)
        self.assertTrue(mock_connection.execute.called_once)
