
    
    

with dbt_test__target as (

  select product_id as unique_field
  from `key-hope-406212`.`ae_data_vault`.`product_hub`
  where product_id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


