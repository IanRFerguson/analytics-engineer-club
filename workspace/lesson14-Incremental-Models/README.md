# Writing Incremental Models

When you set `materialized='incremental'`...
* The **first** time dbt runs this model, it creates a table
* When you **re-run** the model, dbt inserts new records into the table

```sql
-- This goes in your model .sql file
{{ config(
    materialized='table'
) }}

with events as (
    select * from {{ source('advanced_dbt_examples', 'form_events') }}
),

aggregated as (
    select
        github_username,
        min(timestamp) as first_form_entry,
        max(timestamp) as last_form_entry,
        count(*) as number_of_entries
    from events
    group by 1
)

select * from aggregated
```

## Configuring Incremental Models

* Start with a **view** ... when that gets too slow, use an **incremental model**

* First, do two things
  * Set `materialized='incremental'`
  * Tell dbt how to identify new records

* The macro `{{ this }}` uses the current databaes object mapped to the model

* `is_incremental()` checks four conditions
  * Does the model already exist as a db object?
  * Is that database object a table?
  * Is this model configured with `materialized='incremental'`?
  * Was the `--full-refresh` flag passed to this `dbt run`?
  * Yes Yes Yes No == `incremental run`

```sql
with events as (
    select * from {{ source('advanced_dbt_examples', 'form_events') }}

    -- What did Claire say?
    -- This macro checks for existing model
    {% if is_incremental() %}
    where timestamp >= (select max(last_form_entry) from {{ this }})
    {% endif %}
)
```

## Handling Late Data / Custom Cadence

* You can play with the `where timestamp` component of the SQL above

```sql
-- E.g., add interval
where timestamp > (
    select 
        date_add(max(last_form_entry), interval -1 hour) 
    from {{ this }}
)
```

