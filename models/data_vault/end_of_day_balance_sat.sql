{{ config(
    schema='data_vault', 
    alias='end_of_day_balance_sat',
    materialized='table') }}

WITH source as (
   select * from {{ ref('stg_sources__completedtrans') }}
),

eod_hub AS (
select * from {{ ref('end_of_day_balance_hub') }}
),


eod_source AS (
    select v.eod_balance_hsh, v.eod_balance_event_id, 
    s.trans_id, s.account_id, s.fulldate, s.balance, s.rec_src 
    from eod_hub v
    inner join source s on v.eod_balance_event_id = s.trans_id
),

eod_rows AS (
    select rownr_a0+1 as rownr_a1, * from (
        select
        row_number() over (partition by account_id order by fulldate desc) as rownr_a0, *
        from eod_source
        order by 4,5 desc
    )
),

current_rows AS (
    select 
    eod_balance_hsh,
    fulldate AS valid_from_date,
    cast('9999-12-31' as date) AS valid_to_date,
    True as current_indicator,
    False as deleted_indicator,
    eod_balance_event_id,
    balance as eod_balance_amount,
    rec_src

    from eod_rows
    where rownr_a0 = 1),

deleted_valid_to AS (
    select 
    a.eod_balance_hsh, a.rownr_a0, a.account_id, a.eod_balance_event_id,
    a.balance as balance_a, a.fulldate as fulldate_a,
    b.balance as balance_b, b.fulldate as fulldate_b, a.rec_src 
    from eod_rows a
    inner join eod_rows b on a.account_id = b.account_id and a.rownr_a0 = b.rownr_a1
),

deleted_rows AS (
    select 
    eod_balance_hsh,
    fulldate_a AS valid_from_date,
    fulldate_b AS valid_to_date,
    False as current_indicator,
    True as deleted_indicator,
    eod_balance_event_id,
    balance_a as eod_balance_amount,
    rec_src

    from deleted_valid_to
    where rownr_a0 <> 1
),

all_rows AS (
    select * from current_rows
    union all
    select * from deleted_rows
)

select 
    eod_balance_hsh,
    valid_from_date,
    sha256(concat(eod_balance_event_id, cast(eod_balance_amount as string))) as eod_balance_hsh_diff,
    rec_src,
    valid_to_date,
    current_indicator,
    deleted_indicator,
    eod_balance_event_id,
    round(eod_balance_amount, 2) as eod_balance_amount
from all_rows
order by valid_from_date desc