-- Auto-check for Exercise 04. Run after the agent has created both views.
-- Verifies correctness AND that the mart depends on the staging view.

USE SCHEMA CORTEX_PARTNER_DEMO.SALES;

SELECT CASE
    WHEN (SELECT COUNT(*) FROM STG_CUSTOMER_ORDERS) = 10
     AND (SELECT COUNT(*) FROM MART_MONTHLY_REVENUE) = 8
     AND (SELECT SUM(total_revenue) FROM MART_MONTHLY_REVENUE) = 147000
     AND GET_DDL('VIEW', 'MART_MONTHLY_REVENUE') ILIKE '%STG_CUSTOMER_ORDERS%'
    THEN 'PASS' ELSE 'FAIL'
END AS result;
