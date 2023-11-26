

WITH source as (
   select product_id, product_name, rec_src from `key-hope-406212`.`ae_staging`.`stg_sources__account`
),

source_unique AS (
    select * from (
    select product_id, product_name, rec_src, 
    row_number() over (partition by product_id order by rec_src) AS rownr
    from source)
    where rownr=1
),

source_join AS (
    select p.product_hsh, p.product_id, s.product_name, s.rec_src from source_unique s
    inner join `key-hope-406212`.`ae_data_vault`.`product_hub` p on cast(s.product_id as string)=p.product_id
),

source_fields AS (SELECT DISTINCT
    product_hsh,
    '2018-12-31' AS valid_from_date,
    rec_src,
    '9999-12-31' AS valid_to_date,
    True as current_indicator,
    False as deleted_indicator,
    product_id,
    product_name

    FROM source_join
)

SELECT
    product_hsh,
    valid_from_date,
    sha256(concat(product_id, product_name)) as product_hsh_diff,
    rec_src,
    valid_to_date,
    current_indicator,
    deleted_indicator,
    product_id as p_product_id,
    product_name as p_product_name
from source_fields 
order by product_id