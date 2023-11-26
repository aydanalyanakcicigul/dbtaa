
    
    

with all_values as (

    select
        current_indicator as value_field,
        count(*) as n_records

    from `key-hope-406212`.`ae_dim_dwh`.`dim_account`
    group by current_indicator

)

select *
from all_values
where value_field not in (
    True,False
)


