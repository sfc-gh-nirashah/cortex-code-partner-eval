-- Auto-check for Exercise 02. Run after the agent has created the
-- MONTHLY_REGION_REVENUE view. Prints PASS or FAIL.

USE SCHEMA CORTEX_PARTNER_DEMO.SALES;

SELECT CASE
    WHEN COUNT(*) = 8 AND SUM(total_revenue) = 147000
    THEN 'PASS' ELSE 'FAIL'
END AS result,
COUNT(*)           AS row_count,
SUM(total_revenue) AS total_revenue
FROM MONTHLY_REGION_REVENUE;
