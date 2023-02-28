# dbt Tests

### Built-In Tests

`dbt` ships with many default tests...

* Not Null
* Unique
* Relationships
* Accepted Values

### Writing Custom Tests

You can write custom tests in SQL files and store them in one of two places...

* `/tests/generic`
* `/macros`

In the example below, notice that the test is being written much like a macro...

```sql
{% test is_even(model, column_name) %}

with validation as (

    select
        {{ column_name }} as even_field

    from {{ model }}

),

validation_errors as (

    select even_field
    from validation
    
    -- if this is true, then even_field is actually odd!
    where (even_field % 2) = 1

)

select *
from validation_errors

{% endtest %}
```

The idea here is that 0 results == a succcessful test ... we're looking for instances where the test fails


### The `tests` Directory

You can add any one-off or "bespoke" tests to the `/tests` directory. Adding tests to the `/tests/generic` directory makes them ...

* Reusable across models
* Evident in the docs
* Able to share other features
  * Setting a severity (warn / fail)
  * Set thresholds for failure
  * Store any tests in an additional table for auditing purposes


### Database admin tools

Hooks and operations are ways to run snippets of SQL, and can be useful for db administration (e.g., granting permission to query the tables you make in dbt)

```sql
GRANT `roles/bigquery.dataViewer`
ON SCHEMA MY_DATASET
TO "<user: ianferguson@test.com>"
```