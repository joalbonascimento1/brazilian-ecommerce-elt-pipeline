WITH orders AS (SELECT *
from {{ ref('stg_orders') }}
),
order_items AS ( SELECT *
from {{ ref('stg_order_items') }} 
),
customers as ( SELECT *
from {{ ref('stg_customers') }}
),
products as (SELECT *
from {{ ref('stg_products') }}
),

joined as ( SELECT
    p.product_category_name,
    c.customer_state,
    oi.price
    from products p
    left join order_items oi ON p.product_id = oi.product_id
    left join orders o ON oi.order_id = o.order_id
    left join customers c ON c.customer_id = o.customer_id
)
select * from joined
