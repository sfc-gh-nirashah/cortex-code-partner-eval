-- Auto-check for Exercise 2.
-- 1. Paste Cortex Code's FIXED query where indicated (remove any trailing ;).
-- 2. Run the whole script in Snowsight. It prints PASS or FAIL.
-- Requires the fixed query to keep the alias total_revenue (as in broken.sql).

USE SCHEMA CORTEX_PARTNER_DEMO.SALES;

WITH candidate AS (
    -- >>> PASTE YOUR FIXED QUERY HERE <<<
    SELECT
        DATE_TRUNC('month', o.order_date) AS sales_month,
        c.region,
        COUNT(DISTINCT o.order_id)         AS order_count,
        SUM(o.amount)                      AS total_revenue,
        AVG(o.amount)                      AS avg_order_value
    FROM ORDERS o
    INNER JOIN CUSTOMERS c ON o.customer_id = c.customer_id
    WHERE o.order_date >= '2024-01-01'
    GROUP BY 1, 2
    -- >>> END PASTE <<<
)
SELECT
    CASE
        WHEN COUNT(*) = 8 AND SUM(total_revenue) = 147000
        THEN 'PASS'
        ELSE 'FAIL'
    END AS result,
    COUNT(*)            AS row_count,
    SUM(total_revenue)  AS total_revenue
FROM candidate;
