-- Auto-check for Exercise 04. Run after the agent has created the
-- customer_tier UDF. Prints PASS or FAIL.

USE SCHEMA CORTEX_PARTNER_DEMO.SALES;

SELECT CASE
    WHEN customer_tier(63000) = 'Gold'
     AND customer_tier(30000) = 'Gold'
     AND customer_tier(18000) = 'Silver'
     AND customer_tier(10000) = 'Silver'
     AND customer_tier(3200)  = 'Bronze'
    THEN 'PASS' ELSE 'FAIL'
END AS result;
