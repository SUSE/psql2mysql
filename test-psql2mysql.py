#
# coding=utf8
#

import unittest
import mock
import importlib

p2m = importlib.import_module("psql2mysql")


class FakeColumn():
    def __init__(self, name, type):
        self.name = name
        self.type = type

    def name(self):
        return self.name

    def type(self):
        return self.type


class FakeTable():
    def __init__(self, name, columns):
        self.name = name
        self.columns = columns


class TestDbWrapper(unittest.TestCase):
    def setUp(self):
        self.db_wrapper = p2m.DbWrapper()


    def test_getStringColumns(self):
        table = FakeTable("test",
                          [FakeColumn("age", "int"),
                           FakeColumn("name", "VARCHAR"),
                           FakeColumn("noname", " VARCHAR"),
                           FakeColumn("description", "TEXT")
                          ])
        result = self.db_wrapper.getStringColumns(table)
        self.assertEqual(["name", "description"], result)

    @mock.patch('psql2mysql.DbWrapper.getStringColumns')
    @mock.patch('psql2mysql.DbWrapper._query_utf8mb4_rows')
    def test_scanTablefor4ByteUtf8Char(self, mock_utf8mb_rows,
                                       mock_getStringColumns):
        table = FakeTable("test", [])
        mock_getStringColumns.return_value = ["name"]
        mock_utf8mb_rows.return_value = [
            { "name": u"tei\U0010ffffst", "id": 1},
            { "name": "name with Ä", "id": 2},
            { "name": u"ascii name", "id": 3}
        ]
        result = self.db_wrapper.scanTablefor4ByteUtf8Char(table)
        column, row = result[0]
        self.assertEqual(len(result), 1)
        self.assertEqual("name", column)
        self.assertEqual(1, row["id"])
