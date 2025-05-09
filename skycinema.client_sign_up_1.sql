-- ### Задача 2


select a.id_client
        , b.name_city
        , case when gender ilike 'M' then 1 else 0 end as nflag_gender
        , a.age
        , a.first_time
        , case when cellphone is not null then 1 else 0 end as nflag_cellphone
        , a.is_active
        , a.cl_segm
        , a.amt_loan
        , a.date_loan::timestamp as tmt_date_loan
        , a.credit_type
        , sum(a.amt_loan) over (partition by b.name_city order by a.amt_loan desc) as sum_city_loan
        , a.amt_loan * 1.0 / sum(a.amt_loan) over (partition by b.name_city order by a.amt_loan desc) as share_city_loan
        , sum(a.amt_loan) over (partition by a.credit_type order by a.amt_loan desc) as sum_credit_type_loan
        , a.amt_loan * 1.0 / sum(a.amt_loan) over (partition by a.credit_type order by a.amt_loan desc) as share_credit_type_loan
        , sum(a.amt_loan) over (partition by b.name_city, a.credit_type order by a.amt_loan desc) as sum_city_type_loan
        , a.amt_loan * 1.0 / sum(a.amt_loan) over (partition by b.name_city, a.credit_type order by a.amt_loan desc) as share_city_type_loan
        , count(*) over (partition by b.name_city) as cnt_loan
        , count(*) over (partition by a.credit_type) as cnt_type_loan
        , count(*) over (partition by b.name_city, a.credit_type) as cnt_city_type_loan
    
from skybank.late_collection_clients as a
    left join skybank.region_dict as b on a.id_city = b.id_city
