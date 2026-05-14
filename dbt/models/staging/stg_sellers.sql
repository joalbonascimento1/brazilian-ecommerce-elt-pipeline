WITH source AS (
    SELECT * from {{ source('olist','olist_sellers_dataset') }}
),
renamed as (
    SELECT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
    FROM source
)
SELECT * FROM renamed