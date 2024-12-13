with data as (
    select
        date,
        SUM(quantity) filter (where drink_name = 'Eggnog') as eggnog,
        SUM(quantity) filter (where drink_name = 'Hot Cocoa') as hot_cocoa,
        SUM(quantity) filter (where drink_name = 'Peppermint Schnapps') as schnapps
    from drinks
    group by date
)
select
    date
from data
where hot_cocoa = '38' and schnapps = '298' and eggnog = '198';


-- other solution
SELECT date FROM drinks WHERE drink_name = 'Hot Cocoa' GROUP BY date HAVING sum(quantity) = 38
INTERSECT
SELECT date FROM drinks WHERE drink_name = 'Peppermint Schnapps' GROUP BY date HAVING sum(quantity) = 298
INTERSECT
SELECT date FROM drinks WHERE drink_name = 'Eggnog' GROUP BY date HAVING sum(quantity) = 198
;