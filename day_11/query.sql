with ordered as (
    select
        *,
        case
            when season = 'Spring' then 1
            when season = 'Summer' then 2
            when season = 'Fall' then 3
            when season = 'Winter' then 4
        end as season_nb
    from treeharvests
)

select
    field_name,
    harvest_year,
    season,
    round(avg(trees_harvested) OVER (
        partition by field_name
        order by harvest_year, season_nb desc
        rows between current row and 2 following
    ), 2) as tree_avg
from ordered
order by tree_avg desc nulls last
