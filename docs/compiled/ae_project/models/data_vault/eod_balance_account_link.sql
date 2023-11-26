

WITH link_source as (
   select trans_id, account_id from `key-hope-406212`.`ae_staging`.`stg_sources__completedtrans`
),

lookup_acc AS (
    select account_hsh, account_id from`key-hope-406212`.`ae_data_vault`.`account_hub`
),

lookup_eod AS (
    select eod_balance_hsh, eod_balance_event_id from `key-hope-406212`.`ae_data_vault`.`end_of_day_balance_hub`
)

SELECT DISTINCT
    sha256(concat(eod.eod_balance_hsh,ac.account_hsh)) as link_hsh,
    eod.eod_balance_hsh,
    ac.account_hsh
FROM link_source ls
INNER JOIN lookup_acc ac ON ls.account_id = ac.account_id
INNER JOIN lookup_eod eod ON ls.trans_id = eod.eod_balance_event_id