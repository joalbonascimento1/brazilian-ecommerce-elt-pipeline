WITH orders AS (
    SELECT * FROM {{ ref('stg_orders')}}
    ),
order_items AS (
    SELECT * FROM {{ ref('stg_order_items') }}
),
products AS (
    SELECT * FROM {{ ref('stg_products')}}
),
joined AS (
    SELECT
        o.order_id,
        p.product_category_name,
        oi.price
        FROM orders o
        LEFT JOIN order_items oi on o.order_id = oi.order_id
        LEFT JOIN products p ON oi.product_id = p.product_id
        WHERE order_status = 'delivered'
)
SELECT * FROM joined
-- Juntei as tabelas e filtrei somente os pedidos entregues