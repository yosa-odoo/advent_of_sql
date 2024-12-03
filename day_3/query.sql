-- polar_celebration: food_item_id, total_present
-- northpole_database: food_item_id, total_count
-- christmas_feast: food_item_id, total_guests

WITH menu AS (
    SELECT
        CASE
            WHEN xmlexists('//total_present/text()' PASSING BY REF menu_data)
                THEN (xpath('//total_present/text()', menu_data))[1]::text::integer -- xml cannot be casted directly to integer
            WHEN xmlexists('//total_count/text()' PASSING BY REF menu_data)
                THEN (xpath('//total_count/text()', menu_data))[1]::text::integer
            WHEN xmlexists('//total_guests/text()' PASSING BY REF menu_data)
                THEN (xpath('//total_guests/text()', menu_data))[1]::text::integer
        END AS total_guest,
        (xpath('//food_item_id/text()', menu_data))::text[] AS array_food_item -- array of xml element must be casted into array of text
    FROM christmas_menus
)
SELECT
    UNNEST(array_food_item) AS food_item
FROM menu
WHERE total_guest > 78
GROUP BY food_item
ORDER BY COUNT(*) DESC
LIMIT 1;
