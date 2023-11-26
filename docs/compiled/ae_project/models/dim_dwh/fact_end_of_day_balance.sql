

WITH source AS (
    select distinct
    CASE WHEN cls.contact_id is null then ch.contact_id
    when cls.contact_id is not null then cls.contact_id end as contact_id,
    CASE WHEN cls.contact_id is null then ch.contact_id
    when cls.contact_id is not null then cls.rel_contact_id end as alternative_contact_id,
    ah.account_id, ph.product_id,
    ebs.valid_from_date, ebs.valid_to_date, 
    current_indicator as latest_eod_balance_indicator,
    eod_balance_amount

    from `key-hope-406212`.`ae_data_vault`.`account_contact_link` acl
    inner join `key-hope-406212`.`ae_data_vault`.`account_hub` ah on ah.account_hsh=acl.account_hsh
    inner join `key-hope-406212`.`ae_data_vault`.`contact_hub` ch on ch.contact_hsh=acl.contact_hsh
    left join `key-hope-406212`.`ae_data_vault`.`contact_link_sa` cls on (ch.contact_hsh = cls.contact_hsh or ch.contact_hsh = cls.rel_contact_hsh)
    inner join `key-hope-406212`.`ae_data_vault`.`account_product_link` apl on ah.account_hsh=apl.account_hsh
    inner join `key-hope-406212`.`ae_data_vault`.`product_hub` ph on apl.product_hsh=ph.product_hsh
    inner join `key-hope-406212`.`ae_data_vault`.`eod_balance_account_link` ebal on ah.account_hsh=ebal.account_hsh
    inner join `key-hope-406212`.`ae_data_vault`.`end_of_day_balance_hub` ebh on ebal.eod_balance_hsh=ebh.eod_balance_hsh
    inner join `key-hope-406212`.`ae_data_vault`.`end_of_day_balance_sat` ebs on ebh.eod_balance_hsh=ebs.eod_balance_hsh

order by contact_id, account_id, valid_from_date desc),

dim_contact AS (
    select distinct dim_contact_id, s.* 
    from `key-hope-406212`.`ae_dim_dwh`.`dim_contact` dc
    left join source s on dc.contact_id=s.contact_id and dc.alternative_contact_id=s.alternative_contact_id
),

dim_account AS (
    select distinct dim_account_id, s.* 
    from `key-hope-406212`.`ae_dim_dwh`.`dim_account` da
    inner join dim_contact s on da.account_id=s.account_id
),

dim_product AS (
    select distinct dim_product_id, s.* 
    from `key-hope-406212`.`ae_dim_dwh`.`dim_product` dp
    inner join dim_account s on dp.product_id=s.product_id
),

dim_valid_from_date AS (
    select dim_date_id as dim_eod_valid_from_date_id, s.* 
    from `key-hope-406212`.`ae_dim_dwh`.`dim_date` dd
    inner join dim_product s on dd.date=s.valid_from_date
),

dim_valid_to_date AS (
    select dim_date_id as dim_eod_valid_to_date_id, s.* 
    from `key-hope-406212`.`ae_dim_dwh`.`dim_date` dd
    inner join dim_valid_from_date s on dd.date=s.valid_to_date),

final AS (
select 
    dim_contact_id,
    dim_account_id,
    dim_product_id,
    dim_eod_valid_from_date_id,
    dim_eod_valid_to_date_id,
    latest_eod_balance_indicator,
    eod_balance_amount

from dim_valid_to_date
)

select * from final