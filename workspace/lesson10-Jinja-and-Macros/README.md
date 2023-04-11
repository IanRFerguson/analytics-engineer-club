# Jinja

* Templating language that allows you to feed / populate variables that are rendered later
  * Think about email templates ... `Hi {{ first_name }}...`

* Jinja is most common in Python
  * Liquid == equivalent for Ruby

* Generally `{{ }}` means "print something" ... placeholder
  

## Data Types

* You can use **strings**, **integers**, **decimals / floats**, **booleans**, **arrays**, **dictionaries**

### Lists

* Ordered collections of items

Declare lists with `[]` brackets like in Python
`{% set coffee_types = ['cold brew', 'espresso', 'drip'] %}`

Once instantiated you can perform list functions on your variable
`{% do coffee_types.append('pourover') %}`

Add a `|` pipe to run a function in-line
`{{ coffee_types | length }}`
`{{ coffee_types[0] | upper | replace(" ", "_") }}`


### Dictionaries

* Same as Python - key:value pairs, unordered

`{% set cold_brew = {'contains_milk': false, 'country_of_origin':'Kenya'} }}`
`{{ cold_brew.get('contains_milk') }}`

## Control Structures

* Parts of the code that do different things depending on conditions
* E.g., `if` `else` etc...

## Macros

* Macros are functions
* Usually return a string

`{% macro my_coffee_feelings(coffee_type, feeling='love') %}`
`I {{ feeling }} {{ coffee_type }}!!`
`{% endmacro %}`

`{{ my_coffee_feelings('pourover') }}` => `I love pourover!!`