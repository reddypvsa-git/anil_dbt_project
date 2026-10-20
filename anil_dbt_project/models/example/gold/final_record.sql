{{
    config(
        materialized = 'incremental',
        database = 'dbtpro_snowflake',
        schema = 'GOLD',

        unique_key = ['sales_ID','eff_start_date','DBT_SCD_ID'],

        incremental_strategy = 'merge',

        merge_update_columns = [
            'sales_id',
            'product_name',
            'category',
            'total_sales',
            'total_gross_amount',
            'full_name',
            'email',
            'phone',
            'date',
            'payment_method',
            'DBT_SCD_ID',
            'dbt_updated_at',
            'eff_start_date',
            'eff_end_date'
        ]
    )
}}

select 
    sales_id,
    product_name,
    category,
    total_sales,
    total_gross_amount,
    full_name,
    email,
    phone,
    date,
    payment_method,
    dbt_valid_from AS eff_start_date,
    DBT_SCD_ID,
    dbt_updated_at,


    COALESCE(
        dbt_valid_to,
        '9999-12-31'::DATE
    ) AS eff_end_date
from
    {{ ref('gold_one') }}

{% if is_incremental() %}

WHERE dbt_updated_at > (
    SELECT COALESCE(
        MAX(eff_start_date),
        '1900-01-01'::TIMESTAMP
    )
    FROM {{ this }}
)

{% endif %}