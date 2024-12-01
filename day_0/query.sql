
WITH average_nice_score AS (
    SELECT
        count(c.child_id),
        avg(c.naughty_nice_score) avg_nice,
        c.city,
        c.country
    FROM Children c
    JOIN
        ChristmasList cl
            ON cl.child_id = c.child_id
    WHERE cl.was_delivered IS TRUE
    GROUP BY city, country
    HAVING count(c.child_id) >= 5
),
    ranking_city_nice_score AS (
    SELECT city,
           avg_nice,
           RANK() OVER (PARTITION BY country, avg_nice) ranking
    FROM average_nice_score
)

SELECT
    city,
    ranking,
    avg_nice
FROM ranking_city_nice_score
WHERE RANKING <= 3
ORDER BY avg_nice DESC;