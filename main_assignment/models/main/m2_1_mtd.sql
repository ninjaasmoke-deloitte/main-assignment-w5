{{config(materialized = 'incremental', unique_key='Code')}}

select First_nav.code as Code,
    First_nav.nav_date as "Init Date",
    First_nav.nav as "Initial Nav",
    End_nav.nav_date as "Last Date",
    End_nav.nav as "Current Nav",
    (
        (End_nav.nav - First_nav.nav) / First_nav.nav * 100
    ) as "MTD Performance"
from (
        select nav,
            code,
            nav_date
        from nav_history
        where nav_date = date_trunc(
                'MONTH',
                to_date('{{ var("current_date_local") }}')
            )
    ) First_nav
    join (
        select nav,
            code,
            nav_date
        from nav_history
        where nav_date = '{{ var("current_date_local") }}'
    ) End_nav on First_nav.code = End_nav.code