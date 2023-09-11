with visitors as (
    select distinct
        visitor_id,

        -- First value returns the first value of a partition
        -- Unbounded ... not sure look this up
        -- I think this helps identify mismatches in visitor ID and customer ID
        first_value(customer_id ignore nulls) over (
            partition by visitor_id
            order by timestamp
            range between unbounded preceding and unbounded following
        ) as first_customer_id,

        -- Minimum time visited by visitor_id
        min(timestamp) over (
            partition by visitor_id
        ) as first_seen_at,

        -- Maximum time visited by visitor_id
        max(timestamp) over (
            partition by visitor_id
        ) as last_seen_at

    -- This is defined in the local `src_webtracking.yml` file
    from {{ source('web_tracking', 'pageviews') }}
)

select
    *,

    -- See above ... this returns either customer ID or visitor ID
    first_value(visitor_id) over (
        partition by coalesce(first_customer_id, visitor_id)
        order by first_seen_at
    ) as first_visitor_id

from visitors