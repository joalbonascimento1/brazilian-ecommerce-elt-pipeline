with orders as (
    SELECT * FROM {{ ref('stg_orders') }}
),
customers as (
    SELECT * FROM {{ ref('stg_customers') }}
),

joined as (
    SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    o.purchased_at,
    o.approved_at,
    o.delivered_to_carrier_at,
    o.delivered_to_customer_at,
    o.estimated_delivery_at,
    c.customer_unique_id,
    c.customer_zip_code_prefix,
    c.customer_city,
    c.customer_state
    FROM orders o
    LEFT JOIN customers c ON o.customer_id = c.customer_id
)
select * from joined