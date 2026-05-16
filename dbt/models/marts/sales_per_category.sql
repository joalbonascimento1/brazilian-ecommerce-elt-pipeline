WITH sales AS (
    SELECT * FROM {{ ref('int_products_with_orders_and_items') }}
),
sales_per_category AS (
    SELECT
    product_category_name as category_name,
    count(*) as total_orders_count,
    round(sum(price)::numeric, 2) as total_revenues
    FROM sales
    WHERE product_category_name is not NULL
    GROUP BY product_category_name
    ORDER BY total_revenues desc
)
SELECT * from sales_per_category