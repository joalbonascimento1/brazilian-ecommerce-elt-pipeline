select table_name 
from information_schema.tables 
where table_schema = 'public'

select * from olist_geolocation_dataset limit 20
-- geolocation_zip_code_prefix;
-- geolocation_city
-- geolocation_state

select * from olist_order_items_dataset limit 20
-- order_id
-- order_item_id
-- product_id
-- seller_id
-- shipping_limit_date
-- price
-- freight_value

select * from olist_order_payments_dataset limit 20
-- order_id
-- payment_type
-- payment_value

select * from olist_order_reviews_dataset limit 20
-- review_id
-- order_id
-- review_score

select * from olist_products_dataset limit 20
-- product_id
-- product_category_name
-- product_photos_qty

select * from olist_sellers_dataset limit 20
-- seller_id
-- seller_zip_code_prefix
-- seller_city
-- seller_state

select * from product_category_name_translation limit 20
-- já inseridas

select * from olist_products_dataset limit 20

--------
select * from silver.stg_order_items limit 20
select * from silver.stg_order_payments limit 20
select * from silver.stg_order_reviews limit 20
select * from silver.stg_customers limit 20
select * from silver.stg_orders limit 20
select * from silver.stg_products limit 20
select * from silver.stg_sellers limit 20
select * from silver.stg_orders limit 20
select * from silver.stg_geolocation limit 20


select * from silver.int_products_with_orders_and_items limit 20
select * from silver.int_sellers_avaliation limit 50
select * from silver.int_sales_per_category limit 50
select * from silver.int_sales_per_month limit 50

SELECT * FROM gold.delivery_time_by_state
SELECT * FROM gold.sales_per_category
select * from gold.sellers_evaluation
SELECT * FROM gold.revenue_per_month
SELECT * FROM gold.category_per_state


SELECT
distinct order_status
from silver.stg_orders

select table_name from information_schema.tables
where table_schema = 'silver'

