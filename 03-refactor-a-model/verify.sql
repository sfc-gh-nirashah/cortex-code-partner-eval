-- Auto-check for Exercise 03. Run after the agent has created the
-- REGION_REVENUE view. Prints PASS or FAIL.

USE SCHEMA CORTEX_PARTNER_DEMO.SALES;

WITH got AS (
    SELECT region, CAST(total_revenue AS NUMBER(38,2)) AS total_revenue
    FROM REGION_REVENUE
),
exp AS (
    SELECT * FROM VALUES
        ('West',  36500.00),
        ('East',  47500.00),
        ('North', 63000.00)
    AS t(region, total_revenue)
)
SELECT CASE
    WHEN (SELECT COUNT(*) FROM got) = 3
     AND (SELECT COUNT(*) FROM (SELECT * FROM got MINUS SELECT * FROM exp)) = 0
     AND (SELECT COUNT(*) FROM (SELECT * FROM exp MINUS SELECT * FROM got)) = 0
    THEN 'PASS' ELSE 'FAIL'
END AS result;
