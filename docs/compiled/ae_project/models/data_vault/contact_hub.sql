

WITH source as (
   select * from `key-hope-406212`.`ae_staging`.`stg_sources__contact`
)

SELECT DISTINCT
sha256(client_id) AS contact_hsh,
cast('2018-12-31' as date) AS load_dt,
rec_src,
client_id as contact_id

FROM source