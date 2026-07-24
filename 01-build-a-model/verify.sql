-- Auto-check for Exercise 01. Run in the SAME schema as setup.sql, after the
-- agent has created the CUSTOMER_REVENUE view. Prints PASS or FAIL.

WITH got AS (
    SELECT customer_name,
           region,
           CAST(total_revenue AS NUMBER(38,2)) AS total_revenue,
           order_count
    FROM CUSTOMER_REVENUE
),
exp AS (
    SELECT * FROM VALUES
        ('Acme Corp',   'West',  23500.00, 2),
        ('Globex Ltd',  'East',  29500.00, 2),
        ('Initech',     'West',   3200.00, 1),
        ('Umbrella Co', 'North', 63000.00, 2),
        ('Hooli',       'East',  18000.00, 2),
        ('Pied Piper',  'West',   9800.00, 1)
    AS t(customer_name, region, total_revenue, order_count)
)
SELECT CASE
    WHEN (SELECT COUNT(*) FROM got) = 6
     AND (SELECT COUNT(*) FROM (SELECT * FROM got MINUS SELECT * FROM exp)) = 0
     AND (SELECT COUNT(*) FROM (SELECT * FROM exp MINUS SELECT * FROM got)) = 0
    THEN 'PASS' ELSE 'FAIL'
END AS result;
