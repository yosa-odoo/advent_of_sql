select production_date
from toy_production
order by
    coalesce(toys_produced::float / lag(toys_produced) over (order by production_date),
             0) desc
limit 1;
