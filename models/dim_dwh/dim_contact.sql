{{ config(
    schema='dim_dwh', 
    alias='dim_contact',
    materialized='table') }}

WITH source as (
   select * from {{ ref('contact_sat') }}
),

related_contact AS (
    select s.*, sa.rel_contact_id as c_related_contact_id 
    from source s
    inner join {{ ref('contact_link_sa') }} sa on s.c_contact_id = sa.contact_id
),

unrelated_contact AS (
    select s.* from source s
    left join {{ ref('contact_link_sa') }} sa on (s.c_contact_id = sa.rel_contact_id OR s.c_contact_id=sa.contact_id)
    where sa.rel_contact_id is null
),

all_contact AS (
    select c_contact_id, c_related_contact_id, c_gender, c_birth_date, c_age, c_first_name, c_last_name,
    valid_from_date, valid_to_date, current_indicator, deleted_indicator
    from related_contact
    union all
    select c_contact_id, c_contact_id as c_related_contact_id, c_gender, c_birth_date, c_age, c_first_name, c_last_name,
    valid_from_date, valid_to_date, current_indicator, deleted_indicator
    from unrelated_contact
)

select 
    md5(concat(c_contact_id, c_related_contact_id)) as dim_contact_id,
    c_contact_id as contact_id,
    c_related_contact_id as alternative_contact_id,
    c_gender as gender, 
    c_birth_date as birth_date, 
    c_age as age, 
    c_first_name as first_name, 
    c_last_name as last_name,
    valid_from_date,
    valid_to_date,
    current_indicator,
    deleted_indicator
from all_contact
order by c_contact_id