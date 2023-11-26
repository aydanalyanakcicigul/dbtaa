
    
    

with all_values as (

    select
        latest_eod_balance_indicator as value_field,
        count(*) as n_records

    from `key-hope-406212`.`ae_dim_dwh`.`fact_end_of_day_balance`
    group by latest_eod_balance_indicator

)

select *
from all_values
where value_field not in (
    True,False
)


