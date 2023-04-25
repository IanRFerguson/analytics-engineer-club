# Software Engineering Principles

These are frameworks, not dogmas...

## Write Code for Others to Read

* Strive for code that doesn't NEED documentation

* The best software engineers write code that is...
  * Easy to read
  * Easy to understand
  * Easy to maintain

* Use code to **communicate an idea** to a future, anonymous reader

## Simplicity

* Wherever possible, your code should be as simple as possible to get the job done

* Simple code is simple to maintain

* Two simple rules...
  * Reduce the amount of indentation is required in your code
  * Keep functions less than one page in length

### Reduce Indentation

Avoid excessive nested loops, conditions, and functions. Each layer of nesting requires the reader to maintain an addition "layer" of state in the mind as they're reading your code

```python
# 1-800-BAD-CODE
for x in outer_list:
    for y in inner_list:
        if (x == "something" and y == "else"):
            for z in some_function(x, y):
                do_something(z)
        elif (x == "something"):
            do_something(x)
        else:
            do_something(y)
return True
```

### Keep Functions Small

Can you read your whole function without scrolling? **GOOD**

Functions (and `dbt` models!) should do **one thing and one thing only** ... for example, `get_models_to_write()` should get the relevant models and return them. Write clean, modular code to split functions into single-purpose functions.

```python
def notify_user(table: str) -> None:
    print(f"Heads up, {table} is being written")

def write_table(table: str) -> None:
    db.write_table(table)

def main():
    table = pd.read_csv("./my_table.csv")
    notify_user(table)
    write_table(table)
```

## Modularity + Composability

* **Modularity** = Decomposition of a program into smaller programs
  * These are called **standardized interfaces**
  

* **Composability** =Ability to assemble sub-components into various combinations

* These go hand-in-hand and are important to keep in mind when designing software


* Functions are modulare AND compostable when...
  * Each function does one thing
  * Function has a simple and clear interface

## Style

This is how your code "looks" in all the non-functional ways. This is important!

Every language has its own conventions and preference around style (e.g., `pep8` in Python). Adhering to a syle code isn't just aesthetically pleasing, it reduces the cognitive burden associated with reading code. 

```python
# pep-8 Examples
# Imports at the top
from my_module import excellent_function

# All caps for constants
ITERATIONS = 20

# Snake-case for functions and variables
def run(iter: int) -> None:
    return excellent_function(iter)

my_list = []

for k in range(ITERATIONS):
    my_list.append(run(k))
```

## Topics Not Covered Here...

Dig into these more

* Concurrency and parallelization
* Recursion
* Testing as documentation
* Caching

## Resources

* <a href="https://henrikwarne.com/2015/04/16/lessons-learned-in-software-development/" target="_blank">**Lessons learned in software development**</a>

* <a href="https://codeburst.io/concepts-and-terms-that-every-software-engineer-needs-to-know-17339b8d8ae9" target="_blank">**Concepts and terms that every engineer needs to know**</a>

* <a href="https://www.codewars.com/dashboard" target="_blank">**Codewars**</a>