select start_nav.code,
    (
        (end_nav.nav - start_nav.nav) / nullif(start_nav.nav, 0)
    ) * 100 as ytd
from (
        select nav,
            t2.code as code,
            t2.minimum
        from "MAIN_ASSIGNMENT"."PUBLIC"."NAV_HISTORY" t3
            join (
                select t1.code,
                    min(t1.nav_date) as minimum
                from "MAIN_ASSIGNMENT"."PUBLIC"."NAV_HISTORY" t1
                where year(t1.nav_date) = 2018
                group by t1.code
                order by minimum
            ) t2
        where t3.nav_date = t2.minimum
            and t3.code = t2.code
        order by t2.minimum
    ) start_nav
    join (
        select nav,
            t2.code as code,
            t2.maximum
        from "MAIN_ASSIGNMENT"."PUBLIC"."NAV_HISTORY" t3
            join (
                select t1.code,
                    max(t1.nav_date) as maximum
                from "MAIN_ASSIGNMENT"."PUBLIC"."NAV_HISTORY" t1
                where year(t1.nav_date) = 2018
                group by t1.code
                order by maximum
            ) t2
        where t3.nav_date = t2.maximum
            and t3.code = t2.code
        order by t2.maximum
    ) end_nav on start_nav.code = end_nav.code
order by ytd