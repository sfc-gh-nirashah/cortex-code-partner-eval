A data analyst wrote the following monthly sales report query but it is failing when run against Snowflake. The query is saved at /workspace/broken.sql.

The database contains these two tables in ${SCRATCH_DATABASE}.${SCRATCH_SCHEMA}:

- CUSTOMERS (customer_id INT, customer_name STRING, region STRING)
- ORDERS (order_id INT, customer_id INT, order_date DATE, amount DECIMAL(10,2))

Fix all the bugs in /workspace/broken.sql so that:
1. The query executes without errors
2. It returns monthly revenue and order counts grouped by region
3. It only includes orders from 2024 onwards

Do not change the overall intent of the query — just fix what is broken.
