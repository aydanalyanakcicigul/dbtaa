{{ config(
    schema='data_vault', 
    alias='contact_link_sa',
    materialized='table') }}

WITH source as (
   select contact_id, contact_hsh from {{ ref('contact_hub') }}
),

business_logic AS (select contact_id, contact_hsh,
case when contact_id like 'X%' then substr(contact_id,3,9) else null end as conv_contact_id
from {{ ref('contact_hub') }}
),

related_contacts AS (
select s.contact_id,
s.contact_hsh, 
bl.contact_id as rel_contact_id,
bl.contact_hsh as rel_contact_hsh
from source s
inner join business_logic bl on s.contact_id = bl.conv_contact_id
)

select * from related_contacts