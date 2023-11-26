

WITH source as (
   select * from `key-hope-406212`.`ae_staging`.`stg_sources__completedtrans`
),

eod_source AS (
    select * from (
        select trans_id, rec_src,
        row_number() over (partition by account_id, fulldate order by fulldatewithtime desc) as rownr
        from source
        where balance is not null
    ) where rownr=1
)

SELECT DISTINCT
    sha256(trans_id) AS eod_balance_hsh,
    cast('2018-12-31' as date) AS load_dt,
    rec_src,
    trans_id AS eod_balance_event_id

FROM eod_source