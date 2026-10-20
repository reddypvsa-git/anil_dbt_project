{{ config(
    materialized='table',
    schema='source_gold'
) }}

SELECT
    *
FROM {{ ref('gold_one') }}
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY sales_id
    ORDER BY dbt_valid_from desc
) = 1