select p.*,
    f.category
from {{ ref('m2_1_mtd') }} as p,
    "MAIN_ASSIGNMENT"."PUBLIC"."FUND_CATEGORY" as f
where p.code in (
        select code
        from "MAIN_ASSIGNMENT"."PUBLIC"."MUTUAL_FUND"
        where category_id in (
                select id
                from "MAIN_ASSIGNMENT"."PUBLIC"."FUND_CATEGORY"
                limit 3
            )
    )