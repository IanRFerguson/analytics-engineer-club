with customers as (
  select
    id,
    name,
    email
  from 
    `analytics-engineers-club.coffee_shop.customers`
),

orders as (
  select
    customer_id,
    created_at
  from
    `analytics-engineers-club.coffee_shop.orders`
)

select
  o.customer_id,
  c.name,
  c.email,
  min(o.created_at) as first_order_at,
  count(*) as number_of_orders
from customers c
left join orders o
  on c.id = o.customer_id
group by
  1,2,3
order by
  first_order_at