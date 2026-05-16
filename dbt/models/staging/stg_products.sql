WITH source AS (
    SELECT * from {{ source('olist','olist_products_dataset') }}
    ),
renamed as (
    SELECT
    product_id,
    product_category_name,
    product_photos_qty,
    product_name_lenght as product_name_length,
    product_description_lenght as product_description_length,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
    FROM source
)
select * from renamed
-- Precisei renomear essas colunas, estavam com erro de ortografia
