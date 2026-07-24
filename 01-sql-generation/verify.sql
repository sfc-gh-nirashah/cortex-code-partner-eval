-- Answer key + auto-check for Exercise 1.
-- 1. Paste Cortex Code's generated query where indicated (remove any trailing ;).
-- 2. Run the whole script in Snowsight. It prints PASS or FAIL.
-- Requires the query to return columns named: customer_name, total_amount.

USE SCHEMA CORTEX_PARTNER_DEMO.SALES;

WITH candidate AS (
    -- >>> PASTE YOUR QUERY HERE <<<
    -- (example reference solution shown; replace with Cortex Code's output)
    SELECT c.customer_name,
           c.region,
           SUM(o.amount) AS total_amount
    FROM CUSTOMERS c
    JOIN ORDERS o ON c.customer_id = o.customer_id
    GROUP BY c.customer_name, c.region
    ORDER BY total_amount DESC
    LIMIT 5
    -- >>> END PASTE <<<
)
SELECT
    CASE
        WHEN COUNT(*) = 5
         AND MAX(total_amount) = 63000
         AND MAX(CASE WHEN total_amount = 63000 THEN customer_name END) = 'Umbrella Co'
        THEN 'PASS'
        ELSE 'FAIL'
    END AS result,
    COUNT(*) AS row_count
FROM candidate;
