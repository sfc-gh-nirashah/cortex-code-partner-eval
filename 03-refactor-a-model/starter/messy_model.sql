-- This query returns total revenue per region. It works, but it's hard to read
-- (uses a correlated subquery and a wrapper). Refactor it into a clean view.

SELECT region, SUM(rev) AS total_revenue
FROM (
    SELECT c.region AS region,
           (SELECT SUM(o.amount)
            FROM ORDERS o
            WHERE o.customer_id = c.customer_id) AS rev
    FROM CUSTOMERS c
) sub
WHERE rev IS NOT NULL
GROUP BY region;
