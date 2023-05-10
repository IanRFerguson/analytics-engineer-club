/*
ABOUT

Goal: Create a session_id column for our pageviews table that groups 
together pageviews that are part of a continuous browsing session (per user).

Exercise: Create a dbt model (or should you add this column onto the 
model you created in exercise 1?) that looks like the pageviews table 
but has a session_id column on it.

Define a session as a series of page views that are not separated by a 
gap of more than 30 minutes. If you're feeling stuck, ask your fellow 
students in your cohort Slack group or #self-study! And don't forget 
to share your work in those channels when you're done :)
*/

with pageviews as (
    select * from {{ ref('pageviews_cleaned') }}
),

with_previous_pageview as (
    select
        *,
        lag(timestamp) over (
            partition by blended_user_id
            order by timestamp
        ) as previous_pageview_at
    from pageviews
),

with_pageview_delta as (
    select
        *,
        date_diff(timestamp, previous_pageview_at, minute) as minutes_since_previous_pageview
    from with_previous_pageview

),

with_session_marker as (
    select
        *,
        -- handle first session
        cast(coalesce(minutes_since_previous_pageview > 30, true) as integer) as is_new_session
    from with_pageview_delta
),

with_session_number as (
    select
        *,
        sum(is_new_session) over (
            partition by blended_user_id
            order by timestamp
            rows between unbounded preceding and current row
        ) as session_number
    from with_session_marker
)

select * from with_session_number