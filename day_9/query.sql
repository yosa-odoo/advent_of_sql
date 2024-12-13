with average as (
    select
        reindeer_id,
        exercise_name,
        avg(speed_record) as avg_time
    from training_sessions
    group by reindeer_id, exercise_name
),
    average_max as (
    select
        reindeer_id,
        max(avg_time) as avg_max
    from average
    group by reindeer_id
)
select
    r.reindeer_name,
    round(avg_max, 2)
from average_max as a inner join reindeers as r on r.reindeer_id = a.reindeer_id
order by avg_max desc limit 3;