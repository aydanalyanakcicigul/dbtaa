{{ config(
    schema='dim_dwh', 
    alias='dim_date',
    materialized='table') }}

WITH source as (
   select * from {{ ref('stg_sources__date') }}
)

select 
    md5(cast(full_date as string)) as dim_date_id,
    full_date as date
from source
order by date