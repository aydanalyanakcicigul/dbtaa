

WITH source as (
   select contact_id, contact_hsh from `key-hope-406212`.`ae_data_vault`.`contact_hub`
),

business_logic AS (select contact_id, contact_hsh,
case when contact_id like 'X%' then substr(contact_id,3,9) else null end as conv_contact_id
from `key-hope-406212`.`ae_data_vault`.`contact_hub`
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