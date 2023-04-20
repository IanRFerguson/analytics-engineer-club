# Python Environments

Python rocks, what else is new?

# Debugging in Python

Python has a built in debugger, you can set an inline traceback

```python
import pdb

for i in range(10):
    pbd.set_trace()

    print(f"iter={i}")

    x = denoms[i]

    print(f"denom={x}")

    result = 100 / x
```

<a href="https://docs.python.org/3/library/pdb.html" target="_blank">**See the docs**</a>