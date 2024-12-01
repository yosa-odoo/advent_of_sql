WITH wishes as (
    select
--         distinct on (child_id) child_id, -- not necessary for the problem
        distinct on (child_id) child_id,
        wishes -> 'colors' ->> 0 as first_color,
        json_array_length(wishes -> 'colors') as length_colors,
        wishes ->> 'first_choice' as first_choice,
        wishes ->> 'second_choice' as second_choice
    from wish_lists
--     order by child_id, submitted_date DESC -- not necessary for the problem
)
SELECT
    c.name as name,
    w.first_choice as primary_wish,
    w.second_choice as backup_wish,
    w.first_color as favorite_color,
    w.length_colors as color_count,
    CASE
        WHEN t.difficulty_to_make = 1 then 'Simple Gift'
        WHEN t.difficulty_to_make = 2 then 'Moderate Gift'
        ELSE 'Complex Gift'
     END as gift_complexity,
    CASE
        WHEN t.category = 'outdoor' then 'Outside Workshop'
        WHEN t.category = 'educational' then 'Learning Workshop'
        else 'General Workshop'
    END as workshop_assignment
FROM wishes w
JOIN children c on c.child_id = w.child_id
JOIN toy_catalogue t on t.toy_name=w.first_choice
ORDER BY NAME
LIMIT 5;