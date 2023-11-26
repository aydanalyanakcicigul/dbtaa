

with source as (
    SELECT *, 'fin_a' as rec_src FROM `key-hope-406212`.`fin_a`.`completedtrans`
    union all
    SELECT *, 'fin_b' as rec_src FROM `key-hope-406212`.`fin_b`.`completedtrans`
),

final AS (
  SELECT DISTINCT *
   from source
)

select * from final