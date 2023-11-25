{{ config(
    schema='dim_dwh', 
    alias='dim_account',
    materialized='table') }}

WITH source as (
   select * from {{ ref('account_sat') }}
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