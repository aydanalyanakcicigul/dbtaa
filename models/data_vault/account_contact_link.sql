{{ config(
    schema='data_vault', 
    alias='account_contact_link',
    materialized='table') }}

WITH link_source as (
   select client_id, account_id  from {{ ref('stg_sources__account') }}
),

lookup_acc AS (
select account_hsh, account_id from {{ ref('account_hub') }}
),

lookup_con AS (
select contact_hsh, contact_id from {{ ref('contact_hub') }}
)

SELECT DISTINCT
sha256(concat(ac.account_hsh, co.contact_hsh)) as link_hsh,
ac.account_hsh,
co.contact_hsh
FROM link_source ls
INNER JOIN lookup_acc ac ON ls.account_id = ac.account_id
INNER JOIN lookup_con co ON ls.client_id = co.contact_id