

WITH source as (
   select client_id, sex, fulldate, age, first, middle, last, rec_src from `key-hope-406212`.`ae_staging`.`stg_sources__contact`
),

source_join AS (
    select c.contact_hsh, s.* from source s
    inner join `key-hope-406212`.`ae_data_vault`.`contact_hub` c on s.client_id=c.contact_id
),

source_fields AS (
    SELECT DISTINCT
    contact_hsh,
    '2018-12-31' AS valid_from_date,
    rec_src,
    '9999-12-31' AS valid_to_date,
    True as current_indicator,
    False as deleted_indicator,
    client_id as c_contact_id,
    sex as c_gender,
    fulldate as c_birth_date,
    age as c_age,
    CASE WHEN length(middle)>0 then concat(first, ' ', middle) else first end as c_first_name,
    last as c_last_name
    FROM source_join
)

SELECT
    contact_hsh,
    valid_from_date,
    sha256(concat(c_contact_id, c_gender, c_birth_date, c_age, c_first_name, c_last_name)) as contact_hsh_diff,
    rec_src,
    valid_to_date,
    current_indicator,
    deleted_indicator,
    c_contact_id,
    c_gender, c_birth_date, c_age, c_first_name, c_last_name
from source_fields