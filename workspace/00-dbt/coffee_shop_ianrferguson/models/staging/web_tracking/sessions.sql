with pageviews as (
    -- Query local SQL file
    select * from {{ ref('pageviews') }}
),

with_previous_pagview as (
    select
        *,

        -- lag = Access previous rows based on a defined offset value
        -- Adds previous timestamps per user ID to determine past visits
        lag(timestamp) over (
            partition by blended_user_id
            order by timestamp
        ) as previous_pageview_at

    from pageviews
),

with_pageview_delta as (
    select
        *,

        -- date_diff = Caluclates temporal distance between two datetimes
        -- This yields a numeric representation of time between visits
        date_diff(
            timestamp,
            previous_pageview_at,
            minute
        ) as minutes_since_previous_pageview

    from with_previous_pageview
),

with_session_marker as (
    select
        *,
        cast(
            coalesce(
                -- Returns boolean OR true (for first visits)
                -- true == 1
                minutes_since_previous_pageview > 30, 
                true) 
            as integer) as is_new_session
    
    from with_pageview_delta
),

with_session_number as (
    select
        *,

        -- FILL IN WITH COMMENTS
        sum(is_new_session) over (
            partition by blended_user_id
            order by timestamp
            rows between unbounded preceding and current row
        ) as session_number

    from with_session_marker
)

select * from with_session_number