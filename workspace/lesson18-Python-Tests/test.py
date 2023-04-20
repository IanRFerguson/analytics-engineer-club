#!/bin/python3
import unittest
from calc import do_some_math


class TestAdd(unittest.TestCase):
    def test_add(self):
        values = [5, 25]
        result = do_some_math(operation="add", inputs=values)
        self.assertEqual(result, 30)


class TessSubtract(unittest.TestCase):
    def test_subtract(self):
        values = [50, 15]
        result = do_some_math(operation="subtract", inputs=values)
        self.assertEqual(result, 35)


class TessDivide(unittest.TestCase):
    def test_divide(self):
        values = [16, 4]
        result = do_some_math(operation="divide", inputs=values)
        self.assertEqual(result, 4)


if __name__ == "__main__":
    unittest.main()
