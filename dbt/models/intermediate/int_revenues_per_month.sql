WITH order_items AS (SELECT *
from {{ ref('stg_order_items') }} 
),
orders AS ( SELECT *
FROM {{ ref('stg_orders') }} 
),
joined AS ( SELECT 
    o.order_id as order_id,
    o.purchased_at as purchased_at,
    oi.price as price
    FROM orders o
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.purchased_at is not null
)
SELECT * FROM joined