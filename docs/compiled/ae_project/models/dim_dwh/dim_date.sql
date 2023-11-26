

WITH source as (
   select * from `key-hope-406212`.`ae_staging`.`stg_sources__date`
)

select 
    md5(cast(full_date as string)) as dim_date_id,
    full_date as date,
    year,
    month,
    year_day as day
from source
order by date