with recursive subordinates as (
    select staff_id, array[staff_id] as path
    from staff
    where staff_id = 1

    union all

    select e.staff_id, s.path || e.staff_id
    from staff e
    inner join subordinates s on e.manager_id = s.staff_id
)
select max(array_length(path, 1)) as max_depth
from subordinates;


-- with recursive subordinates as (
--     select
--         staff_id,
--         staff_name,
--         manager_id,
--         array[staff_id] as path
--     from staff
--     where staff_id = 1
--     union all
--     select
--         e.staff_id,
--         e.staff_name,
--         e.manager_id,
--         s.path || e.staff_id
--     from staff e
--     inner join subordinates s on e.manager_id = s.staff_id
-- )
-- select
--     staff_id,
--     staff_name,
--     array_length(path, 1) as level,
--     array_to_string(path, ',') as path
-- from subordinates
-- order  by level desc;