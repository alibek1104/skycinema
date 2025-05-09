-- ### Задача 1


with subquery as (select
        date_trunc('month', date_purchase) as purchase_month
        , sum(amt_payment) as total_payment
from skycinema.client_sign_up
group by purchase_month
order by purchase_month)

select purchase_month
        , total_payment
        , avg(total_payment) over (order by purchase_month rows between 2 preceding and current row) as ma_3
        , avg(total_payment) over (order by purchase_month rows between 5 preceding and current row) as ma_7
        , avg(total_payment) over (order by purchase_month rows between 2 preceding and 2 following) as ma_2side_5
from subquery
order by purchase_month
