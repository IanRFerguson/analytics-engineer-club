# Jinja and SQL

* We're already using Jinja in our `dbt` project!

`{{ config(materialized='table') }}`
`select * from {{ ref('staging_table') }}`

* We can apply these Jinja methods to our `dbt` projects as well - loops, conditionals, etc.

* See `00-dbt/coffee_shop_ianrferguson/models/marts/core/jinja_exercise.sql` for more

# Jinja and dbt

* Macros are defined in `.sql` files in the `macros` directory