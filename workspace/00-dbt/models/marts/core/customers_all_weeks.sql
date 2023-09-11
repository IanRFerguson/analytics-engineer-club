with all_weeks as (
    select * from {{ ref('all_weeks') }}
),

orders as (
    select * from {{ ref('orders') }}
),

customer_weekly_orders as (
    select
        customer_id,
        date_trunc(sold_at, week) as date_week,
        sum(total) as total_revenue
    from orders
    group by 1,2
),

customer_first_week as (
    -- Find the first week so we can only look at weeks onwards for each
    select
        customer_id,
        min(date_week) as first_week
    from customer_weekly_orders
),

spined as (
    select
        cfw.customer_id,
        cfw.first_week,
        aw.date_week,
        
        date_diff(
            cast(aw.date_week as datetime),
            cast(cfw.first_week as datetime),
            week
        ) as week_number
    
    -- Alias these tables or NOT
    from all_weeks aw

    inner join customer_first_week cfw
        on aw.date_week >= cfw.first_week
),

joined as (
    select
        spined.customer_id,
        spined.first_week,
        spined.week_number,
        spined.date_week,

        -- NOTE
        coalesce(customer_weekly_orders.total_revenue, 0) as weekly_revenue,

        -- NOTE
        sum(coalesce(customer_weekly_orders.total_revenue, 0)) over (
            partition by spined.customer_id
            order by spined.week_number
            rows between unbounded preceding and current row
        ) as cumulative revenue

    from spined

    left join customer_weekly_orders
        on spined.customer_id = customer_weekly_orders.customer_id
        and spined.date_week = customer_weekly_orders.date_week
)

select * from joined;