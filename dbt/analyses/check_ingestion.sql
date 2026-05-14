SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

    SELECT * FROM olist_orders_dataset limit 50

SELECT * FROM olist_order_items_dataset limit 50

SELECT * FROM olist_products_dataset limit 50

SELECT * FROM olist_customers_dataset limit 50

SELECT count(*) as total_pedidos FROM olist_orders_dataset

SELECT count(*) - count(order_delivered_customer_date) as pedidos_sem_data
from olist_orders_dataset

--product id join entre products e order_items //
-- order id join entre order_items e orders
-- product_category_name

--Quero saber de onde é o cliente, a categoria que ele comprou e quando isso chegou
--Customers, Order Items e Order Dataset
SELECT 
od.order_id,
od.order_delivered_customer_date,
pd.product_category_name,
c.customer_city, 
c.customer_state
FROM olist_customers_dataset c
LEFT JOIN olist_orders_dataset od
ON c.customer_id = od.customer_id
LEFT JOIN olist_order_items_dataset oi
ON od.order_id = oi.order_id
LEFT JOIN olist_products_dataset pd
ON pd.product_id = oi.product_id
limit 50

--product_id em pd e oi

