# CLI

dbt has a Command Line Interface (CLI) that allows you to execute code without an interpreter

```python
import argparse

parser = argparse.ArgumentParser(
    description = "Sum two integers"
)

parser.add_argument(
    "ints_to_sum",
    nargs=2,
    type=int
)

args = parser.parse_args()

our_sum = sum(args.ints_to_sum)

print(f"The sum of our values is {our_sum}")
```

```bash
# Run the CLI
python sum.py 4 5
```