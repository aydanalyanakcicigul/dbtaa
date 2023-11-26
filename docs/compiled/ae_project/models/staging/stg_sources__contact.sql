

with source as (
    SELECT *, 'crm_a' as rec_src FROM `key-hope-406212`.`crm_a`.`contact`
    union all
    SELECT *, 'crm_b' as rec_src FROM `key-hope-406212`.`crm_b`.`contact`
),

contact_final AS (
  SELECT DISTINCT *
   from source
)

select * from contact_final