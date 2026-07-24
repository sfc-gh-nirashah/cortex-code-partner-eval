-- One-time setup for the SQL exercises (01-04; exercise 08 also runs setup_08.sql).
--
-- No CREATE DATABASE needed. FIRST pick a database + schema you can create tables
-- in — either set it in the Snowsight worksheet context (top-right), or edit and
-- run this line:
--     USE SCHEMA <your_database>.<your_schema>;
--
-- Then run this whole script. It creates the demo tables in your CURRENT schema.

CREATE OR REPLACE TABLE CUSTOMERS (
    customer_id   INT,
    customer_name STRING,
    region        STRING
);
INSERT INTO CUSTOMERS VALUES
    (1, 'Acme Corp',   'West'),
    (2, 'Globex Ltd',  'East'),
    (3, 'Initech',     'West'),
    (4, 'Umbrella Co', 'North'),
    (5, 'Hooli',       'East'),
    (6, 'Pied Piper',  'West');

CREATE OR REPLACE TABLE ORDERS (
    order_id    INT,
    customer_id INT,
    order_date  DATE,
    amount      DECIMAL(10,2)
);
INSERT INTO ORDERS VALUES
    (1,  1, '2024-01-15', 15000.00),
    (2,  1, '2024-02-20',  8500.00),
    (3,  2, '2024-01-10', 22000.00),
    (4,  3, '2024-03-01',  3200.00),
    (5,  4, '2024-01-25', 45000.00),
    (6,  5, '2024-02-14', 12000.00),
    (7,  6, '2024-03-10',  9800.00),
    (8,  2, '2024-03-15',  7500.00),
    (9,  4, '2024-02-28', 18000.00),
    (10, 5, '2024-03-20',  6000.00);

SELECT 'Setup complete in ' || CURRENT_DATABASE() || '.' || CURRENT_SCHEMA()
       || ' (CUSTOMERS=6, ORDERS=10)' AS status;
