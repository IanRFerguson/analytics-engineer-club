# Snapshotting Data

Imagine you have a table of peoples' favorite ice cream flavors...

```sql
select
    favorite_flavor,
    count(*) as total
from `analytics-engineersclub.advanced_dbt_examples.favorite_flavors`
group by 1
order by 2 desc;
```

We can easily determine what the most popular flavors are today with a query like we have above ... but what if we're interested in favorite flavors last week? Or a year ago?

This is a tangible problem ... imagine a customer moves to a new state and you want to determine sales numbers by state. The historical sales numbers for all historical purchases would be wrong, because they'd be mapped to the wrong state!

## Terminology

* **Mutable data** are records that can be changed after they're written
  * **Immutable data**, by contrast, cannot be changed (web views and events)

* **Slowly changing dimensions** can be thought of as "unpredictably changing", like someone changing their address or their ice cream preferences

## How do we handle this?

### Idea one - Change the data source

What if instead of overwriting the data we had a separate table - imagine `ice_cream_flavor_history` - that has the preferred flavor for a user over time. This is the **best** answer, but also the hardest solution - it requires back-end engineering resources, and these are hard to come by

### Idea two - "Snapshot" your data daily

TLDR - **DON'T DO THIS!!**

Imagine you write a query like...

```sql
create table if not exists daily_ice_cream_flavors (
  date_date date,
  ice_cream_flavor string,
  total_fans integer
);

insert into daily_ice_cream_flavors (
  select
    current_date() as date_day,
    favorite_ice_cream_flavor as ice_cream_flavor,
    count(*) as total_fans
  from aec.advanced_dbt.favorite_ice_cream
  group by 1,2
);
```

We've got a few issues here...

* We can't tell *who* changed flavor preferences

* In real life, we're probably doing a lot of transofmrations *before* getting to this point ... if we realize that we made a mistake, that means our final query was incorrect and we won't be able to "backfill" by reconstructing the query

* This "just run once a day" approach has two problems
  * What happens if we miss a day?
  * What happens we run this TWICE a day?

### Idea three - "Snapshot" your source data

What if instead of snapshotting the results of the final query, we took a snapshot of the source data

| id  | name | flavor          | date       |
| --- | ---- | --------------- | ---------- |
| 1   | Ian  | Cookies & Cream | 2023-04-15 |
| 2   | Ian  | Cookies & Cream | 2023-04-16 |
| 3   | Ian  | Cookies & Cream | 2023-04-17 |
| 4   | Ian  | Moose Tracks    | 2023-04-18 |

To see what flavors have changed over time since yesterday, we can run:

```sql 
select
  date_day,
  ice_cream_flavor
  count(*)
from daily_ice_cream_flavors
group by 1,2;
```

Modern data warehouses don't *really* have an issue with storing snapshots every day BUT it was a problem with old warehouses. One solution could look like this

| id  | name | flavor          | updated_at | valid_from | valid_to   |
| --- | ---- | --------------- | ---------- | ---------- | ---------- |
| 1   | Ian  | Cookies & Cream | 2023-01-01 | 2023-01-01 | 2023-04-15 |
| 2   | Ian  | Moose tracks    | 2023-04-15 | 2023-04-15 |            |

To map these **slowly changing dimensions** we need to do the following:

* Check the current results of a query

* Check the existing version of the snapshot table

* Compare the current records with existing records
  * Use a key to match the records (e.g., the `id` column)
  * Choose a strategy for determining if a record has changed
  * Option 1 - use the `updated_at` field to check if something has changed
  * Option 2 - compare the current value in the row to the old values to see if they have changed

* Invalidate any changed records by filling in the `valid_to` timestamp

* Insert the new record

## Snapshots in dbt

dbt's snapshot feature provides a relatively convenient way to snapshot our data ... it goes in the `snapshots` folder of your dbt project

```sql
{% snapshot favorite_ice_cream_flavors %}
{{ config (
    target_schema='dbt_ianferguson',
    unique_key='IanRFerguson',
    strategy='timestamp',
    updated_at='updated_at'
) }}

select *
from `analytics-engineers-club.advanced_dbt_examples.favorite_ice_cream_flavors`
{% endsnapshot %}
```

A few things to note...

* `unique_key` - Tells dbt how to match up two records
* `strategy` - Either `timestamp` or `check_cols` tells dbt which logic it should use to compare those two records
* `updated_at` - Which column to use for timestamp comparison

```bash
# Run your snapshots
dbt snapshot
```

## Limitations

* These are **only** useful if they run regularly

* They will NOT capture changes that happen in between the `snapshot` command

* They can be brittle if the structure of your table frequently changes