{{ config(
    schema='staging', 
    alias='stg_sources__account',
    materialized='view') }}

with source as (
    SELECT *, 'crm_a' as rec_src FROM {{ source('crm_a', 'account') }}
    union all
    SELECT *, 'crm_b' as rec_src FROM {{ source('crm_b', 'account') }}
),

account_final AS (
  SELECT DISTINCT *
   from source
)

select * from account_final