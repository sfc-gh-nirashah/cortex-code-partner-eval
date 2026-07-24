-- Monthly Sales Report: revenue and order count by region and month.
-- This query FAILS to run. Ask Cortex Code to fix it.

SELECT
    DATE_TRUNC('month', order_date)   AS sales_month,
    c.region,
    COUNT(DISTINCT o.order_id)         AS order_count,
    SUM(o.amt)                         AS total_revenue,
    AVG(amount)                        AS avg_order_value
FROM ORDERS o
INNER JOIN CUSTOMERS c ON o.customer_id = c.customer_id
WHERE o.order_dat >= '2024-01-01'
GROUP BY 1, 2
ORDER BY sales_month ASC, total_revenue DESC;
