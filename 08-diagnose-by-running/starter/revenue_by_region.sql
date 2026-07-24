-- Regional revenue report. Looks correct, but the North total comes out doubled.
-- Regions are maintained in the CUSTOMER_REGION_LOOKUP table.

SELECT l.region,
       SUM(o.amount) AS total_revenue
FROM ORDERS o
JOIN CUSTOMER_REGION_LOOKUP l ON o.customer_id = l.customer_id
GROUP BY l.region;
