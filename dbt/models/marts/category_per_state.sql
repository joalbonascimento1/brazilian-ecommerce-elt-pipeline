WITH sales_with_category_and_customer AS (SELECT *
from {{ ref('int_sales_with_category_and_customer') }} 
),
category_per_state_middle as (
    SELECT 
    customer_state as states,
    product_category_name as category,
    round(sum(price::numeric),2) as total_revenue,
    dense_rank() over(PARTITION BY customer_state ORDER BY sum(price) desc) as position
    FROM sales_with_category_and_customer
    GROUP BY states, category
),
category_per_state as (SELECT
    states,
    category,
    total_revenue
    FROM category_per_state_middle
    WHERE position = 1
    ORDER BY states asc
)
select * from category_per_state