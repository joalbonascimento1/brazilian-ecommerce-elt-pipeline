WITH orders as (
    SELECT
    * from {{ ref('int_orders_with_customers') }}
),
delivered as (
    SELECT
    customer_state,
    delivered_to_customer_at - purchased_at as delivery_time
    from orders
    where order_status = 'delivered'
    and delivered_to_customer_at is not NULL
    and purchased_at is not NULL
),

aggregated as (
    SELECT
    customer_state,
    count(*) as total_orders,
    avg(delivery_time) as avg_delivery_time,
    min(delivery_time) as min_delivery_time,
    max(delivery_time) as max_delivery_time
    from delivered
    group by customer_state
)
select * from aggregated
order by avg_delivery_time