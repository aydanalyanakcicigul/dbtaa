

WITH source as (
   select * from `key-hope-406212`.`ae_data_vault`.`product_sat`
)

select 
    md5(p_product_id) as dim_product_id,
    p_product_id as product_id,
    p_product_name as product_name,
    valid_from_date,
    valid_to_date,
    current_indicator,
    deleted_indicator
from source