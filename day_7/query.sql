select c.name
from children c
join gifts g on g.child_id = c.child_id
where g.price > (select avg(price) as p from gifts)
order by g.price

