{{ config(
    schema='staging', 
    alias='stg_sources__completedtrans',
    materialized='view') }}

with source as (
    SELECT *, 'fin_a' as rec_src FROM {{ source('fin_a', 'completedtrans') }}
    union all
    SELECT *, 'fin_b' as rec_src FROM {{ source('fin_b', 'completedtrans') }}
),

final AS (
  SELECT DISTINCT *
   from source
)

select * from final