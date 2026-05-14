WITH sales AS (SELECT *
from {{ ref('int_revenues_per_month') }}
),
revenues_per_month AS (
    SELECT
    date_trunc('month', purchased_at) as month,
    coalesce(round(sum(price::numeric), 2), 0) AS revenue
    FROM sales
    GROUP BY 1
    ORDER BY month desc
    
)
select * from revenues_per_month