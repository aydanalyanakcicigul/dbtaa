{{ config(
    schema='data_vault', 
    alias='account_sat',
    materialized='table') }}

WITH source as (
   select account_id, type, rec_src from {{ ref('stg_sources__account') }}
),

source_join AS (
    select a.account_hsh, s.* from source s
    inner join {{ ref('account_hub') }} a on s.account_id=a.account_id
),

source_fields AS (
    SELECT DISTINCT
    account_hsh,
    '2018-12-31' AS valid_from_date,
    rec_src,
    '9999-12-31' AS valid_to_date,
    True as current_indicator,
    False as deleted_indicator,
    account_id as a_account_id,
    type as a_account_user_type

    FROM source_join
)

SELECT
    account_hsh,
    valid_from_date,
    sha256(concat(a_account_id,a_account_user_type)) as account_hsh_diff,
    rec_src,
    valid_to_date,
    current_indicator,
    deleted_indicator,
    a_account_id,
    a_account_user_type
from source_fields 
