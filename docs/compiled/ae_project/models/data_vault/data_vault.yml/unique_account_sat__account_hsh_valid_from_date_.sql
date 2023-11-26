
    
    

with dbt_test__target as (

  select (account_hsh || '-' || valid_from_date) as unique_field
  from `key-hope-406212`.`ae_data_vault`.`account_sat`
  where (account_hsh || '-' || valid_from_date) is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


