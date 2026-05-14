WITH orders_and_sellers AS (SELECT * 
FROM {{ ref('int_sellers_evaluation') }}
),
sellers_evaluation AS (
    SELECT
    seller_id,
    count(*) as total_sales,
    round(sum(price::numeric),2) as seller_revenue,
    round(avg(review_score::numeric),2) as avg_review_score
    FROM orders_and_sellers
    GROUP BY seller_id
    ORDER BY seller_revenue desc
)
SELECT * FROM sellers_evaluation