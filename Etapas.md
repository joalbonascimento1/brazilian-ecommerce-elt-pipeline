## Roadmap

- [x] Pipeline ELT inicial
- [x] Arquitetura medalhão
- [x] Transformações dbt (criar mais marts:)
- [x] Testes automatizados (Devem ser usados majoritariamente nos stgs pois eles carregam a base da tabela, mas também devem ser usados nas marts, porém para testar regras de negócio)
- [ ] CI/CD
- [ ] Orquestração com Airflow
- [ ] Dashboard no Metabase

-------
marts:
Domínio: Vendedores
seller_performance — avaliação média, total de pedidos, receita por vendedor


raciocinio:
stg_order_items = oi
seller_id,
price,
order_id

stg_order_reviews = orv
review_score,
order_id
-------

 
Domínio: Financeiro
revenue_by_month — faturamento mensal (mostra tendência temporal, importante para portfólio)

raciocínio:
preciso de data e preço (orders e order_items)

stg_order_items = oi
order_id,
price

stg_orders = o
order_id,
purchased_at

estrutura:
order_id,
price,
purchased_at


--------
Domínio: Vendas 2
Buscar TOP Categoria de vendas por estado.

p.product_category_name
c.customer_state
oi.price
from products p
left join order_items oi ON p.product_id = oi.product_id
left join orders o ON oi.order_id = o.order_id
left join customers c ON c.customer_id = o.customer_id

stg_orders = o
order_id,
customer_id

stg_customers = c
customer_id,
customer_state,
 
stg_order_items = oi X
order_id,
product_id,
price

stg_products = p X
product_id,
product_category_name

joins:
