-- Extra setup for Exercise 08. Run AFTER the repo's setup.sql.
-- Creates a region lookup table with a DUPLICATE row for one customer,
-- which causes a fan-out join and doubled revenue in the starter query.

USE SCHEMA CORTEX_PARTNER_DEMO.SALES;

CREATE OR REPLACE TABLE CUSTOMER_REGION_LOOKUP (customer_id INT, region STRING);
INSERT INTO CUSTOMER_REGION_LOOKUP VALUES
    (1, 'West'),
    (2, 'East'),
    (3, 'West'),
    (4, 'North'),
    (4, 'North'),   -- duplicate row for customer 4 (Umbrella Co)
    (5, 'East'),
    (6, 'West');

SELECT 'Exercise 08 setup complete: CUSTOMER_REGION_LOOKUP created (with a duplicate)' AS status;
