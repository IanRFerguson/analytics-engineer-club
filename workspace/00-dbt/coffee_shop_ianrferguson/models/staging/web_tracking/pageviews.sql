-- Query the web_tracking.pagviews table from analytics-engineers-club
with pageviews as (
    select * from {{ source('web_tracking', 'pageviews') }}
),

visitors as (
    -- Query the local visitors.sql file

    select * from {{ ref('visitors') }}
),

joined as (
    -- Create an exhaustive mapping of visitor IDs

    select
        -- Everything from pagviews
        pageviews.*,

        -- First NOT NULL value between these two columns
        coalesce(
            visitors.first_customer_id,
            pageviews.visitor_id
        ) as blended_user_id,

        visitors.first_visitor_id
    
    from pageviews
    left join visitors
        on pageviews.visitor_id = visitors.visitor_id
)

select * from joined