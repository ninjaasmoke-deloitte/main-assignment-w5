select f.category as category,
    max(nav) as max_nav,
    min(nav) as min_nav
from nav_history as n,
    mutual_fund as m,
    fund_category as f
where f.id = m.category_id
    and m.code = n.code
group by f.category
order by max(nav) desc
