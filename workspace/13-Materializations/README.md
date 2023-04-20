# Materializations

*TO DO* - Watch Claire's videos...

To recap...

* Views: Fast to build, slow to query
  
* Tables: Slow to build, fast to query
  
## dbt Materializations

In dbt, materializations use Jinja to execute the SQL required to run / create your object in the warehouse.

```sql
-- Use this tag
{% materialization %}
```

* dbt then chooses which materialization to use based on the configuration
  
* Materialization then executes the SQL
  
* Within each materialization, there's additional logic
  * Conditions check whether model already exists in warehouse
  * Implement extra configs (sort / dist keys, clustering)
  * Run pre- and post-hooks
  * Handle different warehouses (**macros can be warehouse-aware!**)

## Benefits of Writing Materializations

* Avoid writing conditional logic to handle different states of a warehouse

* Don't need to know the trickiest bits of SQL (DML, DDL)

* Switch warehouses relatively easily

Think of materializations as an "abstraction" on top of your warehouse

#### What is declarative programming?

"I want my car to be X temperature" ... car determines if it needs to
turn on the heat or turn on the AC

In dbt, "I want this to exist as a view" - dbt does the rest

## Ephermeral materializations

These **do not** get created in the warehouse ... when you `ref` an ephemeral model, dbt injects the select statement into your current model

```sql
-- What you write
select id from {{ ref('my_ephemeral_model') }}



-- What gets compiled
with __dbt__cte__my_ephemeral_model as (
    select 1 as id
)

select id from __dbt__cte__my_ephemeral_model
```

*What's the point?*

Declutter your warehouse, since these won't be written out as a view or a table