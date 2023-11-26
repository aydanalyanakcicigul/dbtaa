

WITH source as (
   select * from `key-hope-406212`.`ae_data_vault`.`account_sat`
)

select 
    md5(a_account_id) as dim_account_id,
    a_account_id as account_id,
    a_account_user_type as account_user_type,
    valid_from_date,
    valid_to_date,
    current_indicator,
    deleted_indicator
from source