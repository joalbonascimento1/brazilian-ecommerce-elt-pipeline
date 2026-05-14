SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

SELECT * FROM olist_orders_dataset limit 50

SELECT * FROM olist_order_items_dataset limit 50

SELECT * FROM olist_products_dataset limit 50

SELECT * FROM olist_customers_dataset limit 50


-- QTD VENDAS POR ESTADO

WITH info_vendas AS (
    SELECT customer_id, order_id
    FROM olist_orders_dataset 
),
info_clientes AS (
    SELECT customer_id, customer_state
    FROM olist_customers_dataset
),
info_items_vendas AS (
    SELECT order_id, product_id, price
    FROM olist_order_items_dataset
),
info_produtos AS (
    SELECT product_id, product_category_name
    FROM olist_products_dataset
),
contagem_vendas AS (
SELECT 
    ic.customer_state,
    count(iv.order_id) as total_pedidos,
    ip.product_category_name
FROM info_vendas iv
LEFT JOIN info_clientes ic ON iv.customer_id = ic.customer_id
LEFT JOIN info_items_vendas iiv ON iv.order_id = iiv.order_id
LEFT JOIN info_produtos ip ON iiv.product_id = ip.product_id
GROUP BY ic.customer_state, ip.product_category_name
ORDER BY total_pedidos DESC

),
ranking_vendas AS (
    SELECT 
        customer_state,
        product_category_name,
        total_pedidos,
        RANK() OVER (
            PARTITION BY customer_state 
            ORDER BY total_pedidos DESC
        ) as rnk
    FROM contagem_vendas
)
-- select * from ranking_vendas limit 100
SELECT 
    customer_state,
    product_category_name,
    total_pedidos
FROM ranking_vendas
WHERE rnk = 1
ORDER BY total_pedidos DESC
    
-- extrair os dados > tratar /carregar os dados com auditoria > criar arquitetura desses dados




