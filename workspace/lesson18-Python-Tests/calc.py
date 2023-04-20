#!/bin/python3
import argparse

"""
Goal - Write a program that can take an infinite
number of numeric arguments as well as an operation type
"""


def get_arguments():
    """
    Get user arguments from the command line
    """

    parser = argparse.ArgumentParser(
        description="Perform an operation on a set of inputs"
    )

    parser.add_argument("operation", default="add")
    parser.add_argument("numeric_inputs", nargs="*")

    return parser.parse_args()


def do_some_math(operation: str, inputs: list) -> float:
    """
    Perform an operation given user inputs
    """

    starting_value = inputs[0]

    if operation == "add":
        for val in inputs[1:]:
            starting_value += val

    elif operation == "subtract":
        for val in inputs[1:]:
            starting_value -= val

    elif operation == "multiply":
        for val in inputs[1:]:
            starting_value *= val

    elif operation == "divide":
        for val in inputs[1:]:
            try:
                starting_value /= val

            except ZeroDivisionError:
                print("Can't dvivide by 0...")
                starting_value = starting_value

    else:
        raise ValueError(f"{operation} is unknown operation")

    return starting_value


def main():
    args = get_arguments()
    operation = args.operation
    values = [int(x) for x in args.numeric_inputs]
    result = do_some_math(operation=operation, inputs=values)

    print(f"Result of {operation} operation = {result}")


if __name__ == "__main__":
    main()
