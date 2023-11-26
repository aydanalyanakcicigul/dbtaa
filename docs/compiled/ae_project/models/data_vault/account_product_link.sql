

WITH link_source as (
   select product_id, account_id from `key-hope-406212`.`ae_staging`.`stg_sources__account`
),

lookup_acc AS (
select account_hsh, account_id from `key-hope-406212`.`ae_data_vault`.`account_hub`
),

lookup_pro AS (
select product_hsh, product_id from `key-hope-406212`.`ae_data_vault`.`product_hub`
)

SELECT DISTINCT
sha256(concat(ac.account_hsh, pr.product_hsh)) as link_hsh,
ac.account_hsh,
pr.product_hsh
FROM link_source ls
INNER JOIN lookup_acc ac ON ls.account_id = ac.account_id
INNER JOIN lookup_pro pr ON cast(ls.product_id as string) = pr.product_id