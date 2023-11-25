{{ config(
    schema='dim_dwh', 
    alias='dim_product',
    materialized='table') }}

WITH source as (
   select * from {{ ref('product_sat') }}
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