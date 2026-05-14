WITH order_items AS (SELECT * 
from {{ ref('stg_order_items')}}
),
order_reviews AS ( SELECT *
from {{ ref('stg_order_reviews') }}
),
joined AS (
    SELECT
    oi.seller_id,
    oi.price,
    orv.review_score
    FROM order_items oi
    LEFT JOIN order_reviews orv ON oi.order_id = orv.order_id
    WHERE oi.seller_id is not NULL 
)
SELECT * FROM joined