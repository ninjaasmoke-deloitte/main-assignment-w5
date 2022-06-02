{{ config(materialized = 'incremental', unique_key='Code') }}

select First_Nav.code as Code,
    First_Nav.nav_date as "Init Date",
    First_Nav.nav as "Initial Nav",
    Current_Nav.nav_date as "Current Date",
    Current_Nav.nav as "Current Nav",
    (
        (Current_Nav.nav - First_Nav.nav) / First_Nav.nav * 100
    ) as "MTD Performance"
from (
        select nav,
            code,
            nav_date
        from nav_history
        where nav_date = date_trunc('MONTH',to_date('{{ var("current_date_local") }}')) 
            and code in (
                select code
                from mutual_fund
                where category_id in (
                        select id
                        from fund_category
                        where category like '%Liquid%'
                    )
            )
    ) as First_Nav
    join (
        select nav,
            code,
            nav_date
        from nav_history
        where nav_date = '{{ var("current_date_local") }}'
            and code in (
                select code
                from mutual_fund
                where category_id in (
                        select id
                        from fund_category
                        where category like '%Liquid%'
                    )
            )
    ) as Current_Nav on First_Nav.code = Current_Nav.code