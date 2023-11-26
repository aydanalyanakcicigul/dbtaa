
    
    

with all_values as (

    select
        deleted_indicator as value_field,
        count(*) as n_records

    from `key-hope-406212`.`ae_dim_dwh`.`dim_contact`
    group by deleted_indicator

)

select *
from all_values
where value_field not in (
    True,False
)


