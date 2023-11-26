
    
    

with dbt_test__target as (

  select (account_hsh || '-' || eod_balance_hsh) as unique_field
  from `key-hope-406212`.`ae_data_vault`.`eod_balance_account_link`
  where (account_hsh || '-' || eod_balance_hsh) is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


