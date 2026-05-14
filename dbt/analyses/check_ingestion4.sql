select table_name from information_schema.tables
where table_schema = 'public'

select * from olist_customers_dataset limit 20
select * from olist_sellers_dataset limit 20
select * from olist_orders_dataset limit 20
select * from olist_order_items_dataset limit 20

--Quero saber quais os vendedores que mais venderam por estado
WITH sellers AS (
    select 
    seller_id
    from olist_sellers_dataset
),
items_orders AS (
    select 
    seller_id,
    price,
    order_id,
    order_item_id,
    product_id
    from olist_order_items_dataset
),
total_orders AS (
    SELECT 
    order_id
    FROM olist_orders_dataset 
)



select * from items_orders limit 20
select count(DISTINCT seller_state) from olist_sellers_dataset

select * from stg_orders limit 20
SELECT * FROM olist_customers_dataset LIMIT 5