{{ config(
    schema='data_vault', 
    alias='product_hub',
    materialized='table') }}

WITH source as (
   select * from {{ ref('stg_sources__account') }}
),

source_unique AS (
select * from (
select product_id, rec_src, 
row_number() over (partition by product_id order by rec_src) AS rownr
from source)
where rownr=1
)

SELECT DISTINCT
sha256(cast(product_id as string)) AS product_hsh,
cast('2018-12-31' as date) AS load_dt,
rec_src,
cast(product_id as string) as product_id

FROM source_unique