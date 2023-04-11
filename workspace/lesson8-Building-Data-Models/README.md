# Building Data Models

Think about the structural tradeoffs between different approaches...
* Size of table
* Ease of use for end user
* How "cluttered" is your table?

Decisions that your company makes to try and align on **definitions**
* Grain = What counts as an "order" or transaction?
  * How to operationalize business outcomes

* Column = How do we measure something like revenue?
  * Does net include taxes or are they added later?

## Conventions

* Most data teams...
    * Are source data centric
    * Mostly do cleaning work / joining manually
    * Often only one query between source data and data powering a dashboard

* The best data teams...
    * Are business centric
    * Have clear definitions of what one record represents (what's a customer?)
    * Intentional about separating source and business logic in transformations

* Distinction between SOURCE and BUSINESS logic
    * Source tied to systems that produce data (think transformations, renaming fields for consistency)
    * Business logic is more subjective & requires stakeholder input to align on a definition

## Modeling 101

1 - Understanding your stakeholder needs

* Draw a mock dashboard / prototype

* Ask questions 
    ** What will you do differently with this information?
    ** How do you usually get this information?

2 - Check availability of your source data

3 - Mock the end result that you're working towards

* What table maps to this visualization?

* What do you NEED to create this visualization or dashboard?


4 - Mock the SQL you would need to accomplish this

* Write pseudocode!

* Detail what you need and why you need it


5 - Iterate on your data model

* Dimensions, facts, what you'll *do* with facts (averages, medians, ranges, etc.)

6 - Start sketching out a dbt DAG

* What models / tables feed into the resulting output left to right?

* Start building sources (the left-most parts of our DAG)

[ LOOK AT THIS AGAIN ]

7 - Declare sources && build staging models

* Add YAML files to your dbt project for your source data
    * Ensure any assumptions about your source data is recorded and validated here
    * Add information about these sources as you learn more about them

* Staging models clean up your source data into "the shape you wish it came in"
    * Same grain as your source data
    * Renamed fields, reordered columns, etc.
    * Should be tested and documented

* Staging vs. marts
    * Think about it like source data vs. data to hand off for business problems