/* 
ABOUT

Customers may shop our online coffee shop using different devices. 
They might shop on their phone or on their personal computer or on their work computer. 
Until the customer actually signs in to make a purchase we won't be able to link 
that user's browsing sessions across devices.

Goal: We want to link users' browsing sessions together when we know that they are in fact the same user.

Exercise: Create a model in your dbt project that has the same columns as 
web_tracking.pageviews except the visitor_id column should reflect this "user stitching" 
exercise so that each visitor that we know is the same person should have the same visitor_id.

In the new model you create, there should not be any customers with multiple visitor IDs. 
Once you have something in place, share your work in your cohort Slack group or #self-study! 
If you're feeling stuck, don't forget that you can use those Slack channels as a resource!
*/

with visitor_log as (
    select distinct
        visitor_id,

        -- Earliest customer id for each given visitor
        first_value(customer_id ignore nulls) over (
            partition by visitor_id
            order by timestamp

            -- Not sure what this means tbh
            range between unbounded preceding and unbounded following
        ) as first_customer_id,

        -- Earliest instance of visitor shopping
        min(timestamp) over (
            partition by visitor_id
        ) as first_seen_at,

        -- Most recent instance that visitor has shopped
        max(timestamp) over (
            partition by visitor_id
        ) as last_seen_at

        -- From web_tracking.pageviews in warehouse
        from {{ source('web_tracking', 'pageviews') }}
)

select
    *,
    first_value(visitor_id) over (
        partition by coalesce(first_customer_id, visitor_id)
        order by first_seen_at
    ) as first_visitor_id
from visitor_log