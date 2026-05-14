SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';



SELECT * FROM olist_orders_dataset limit 50

SELECT * FROM olist_order_items_dataset limit 50

SELECT * FROM olist_products_dataset limit 50

SELECT * FROM olist_customers_dataset limit 50

--Seu Objetivo
-- Escreva uma query usando CTEs (WITH) que gere o seguinte resultado:
-- Estado do cliente. (olist_customers_dataset)
-- Quantidade total de pedidos realizados naquele estado. count groupy(olist_orders_dataset)
-- Ticket Médio (Valor total das vendas / Quantidade de pedidos) por estado. (price em olist_order_items_dataset)
-- A Categoria de Produto mais vendida (esse é o bônus de dificuldade!).

WITH order_by_state AS (
    SELECT customer_state, customer_id 
    FROM olist_customers_dataset
),
-- select * from order_by_state LIMIT 20

tickets AS (
    SELECT price, order_id, product_id
    FROM olist_order_items_dataset
    ),

-- select * from tickets LIMIT 20

products_cat_reduz AS (
    SELECT product_category_name, product_id
    FROM olist_products_dataset
),

-- select * from products_cat_reduz limit 20

orders_reduzida as (
    SELECT order_id, customer_id
    FROM olist_orders_dataset 
)
-- select * from orders_reduzida limit 20

SELECT
    obe.customer_state,
    count(*) as total_pedidos,
    ROUND(AVG(tk.price)::numeric, 2) AS ticket_medio
FROM 
    orders_reduzida ord
LEFT JOIN 
    order_by_state obe ON ord.customer_id = obe.customer_id
LEFT JOIN
    tickets tk on ord.order_id = tk.order_id
GROUP BY 
    obe.customer_state

