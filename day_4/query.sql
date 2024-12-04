with parsed_data as (
    select
        toy_id,
        array_length(array(select unnest(new_tags) except select unnest(previous_tags)
        ), 1) as added_tags,
        array_length(array(select unnest(new_tags) intersect select unnest(previous_tags)
        ), 1) as unchanged_tags,
        array_length(array(select unnest(previous_tags) except select unnest(new_tags)
        ), 1) as removed_tags
    from toy_production
)
select
    toy_id,
    added_tags,
    unchanged_tags,
    removed_tags
from parsed_data
order by added_tags desc nulls last
limit 1;
