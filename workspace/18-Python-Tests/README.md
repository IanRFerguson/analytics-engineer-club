# Python Testing

**Unit tests** are one type of test that are designed to check ONE piece of functionality in your software. These often map nicely onto single functions - they tend to be best when they're small, simple, and easy to read. Each unit test should test exactly ONE thing.

**Integration tests** are designed to test a wider set of functionality that often has to do with how multiple *different* functions interact. These are useful in more complex pieces of software, where you need to ensure that all the various components work together in harmony. 

```python
# calc.py
import argparse 

def aec_subtract(ints_to_sub):
    arg1, arg2 = ints_to_sub[0], ints_to_sub[1]
    value = arg1 - arg2
    print(f"The subtracted result is {value}")
    
    return value

def main():
    args = parser.parse_args()

    if args.command == "sub":
        our_sub = aec_subtract(args.ints_to_sub)
        print(f"The subtracte result of values is {our_sub}")

if __name__ == __main__:
    main()


#####

# tests/test_subtract.py
import unittest
from calc import aec_subtract

class TestSubtract(unittest.TestCase):
    def test_subtract(self):
        args_ints = [20, 5]
        sub_result = aec_subtract(args_ints)
        self.assertEqual(sub_result, 15)

if __name__ == "__main__":
    unittest.main()
```

Now we run the test...

```bash
python -m unittest -v tests/test_subtract.py
```

## Test-Driven Development

What if we wrote the tests *before* writing the source code? This approach allows us to add fundtionality that will prevent the user from building a program that will behave in a way we don't want it to.