{{ config(
    schema='data_vault', 
    alias='account_hub',
    materialized='table') }}

WITH source as (
   select * from {{ ref('stg_sources__account') }}
)

SELECT DISTINCT
sha256(account_id) AS account_hsh,
cast('2018-12-31' as date) AS load_dt,
rec_src,
account_id

FROM source