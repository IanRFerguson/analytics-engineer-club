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