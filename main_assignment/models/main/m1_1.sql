select extract(
        month
        from nav_date
    ) as Month,
    ROUND(avg(nav), 2) as AVG_NAV,
    ROUND(avg(REPURCHASE_PRICE), 2) as AVG_REPURCHASE_PRICE,
    ROUND(avg(SALE_PRICE), 2) as AVG_SALE_PRICE
from "MAIN_ASSIGNMENT"."PUBLIC"."NAV_HISTORY"
group by extract(
        month
        from nav_date
    )