WITH source AS (
    SELECT * FROM {{ source('olist','olist_order_reviews_dataset') }}
),
renamed as (
    SELECT
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date::timestamp as review_creation_date,
    review_answer_timestamp::timestamp as review_answer_timestamp
    FROM source
)
select * from renamed