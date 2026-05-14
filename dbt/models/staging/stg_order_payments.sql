WITH source AS (
    SELECT * from {{ source('olist','olist_order_payments_dataset') }}
    ),
renamed as (
    SELECT
    order_id,
    payment_type,
    payment_value,
    payment_sequential,
    payment_installments
    FROM source
)
select * from renamed