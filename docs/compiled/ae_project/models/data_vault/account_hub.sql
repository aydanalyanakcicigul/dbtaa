

WITH source as (
   select * from `key-hope-406212`.`ae_staging`.`stg_sources__account`
)

SELECT DISTINCT
sha256(account_id) AS account_hsh,
cast('2018-12-31' as date) AS load_dt,
rec_src,
account_id

FROM source