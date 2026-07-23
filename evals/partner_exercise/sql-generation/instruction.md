You are helping a sales analyst prepare for a quarterly business review.

The Snowflake environment contains two tables in ${SCRATCH_DATABASE}.${SCRATCH_SCHEMA}:

- CUSTOMERS (customer_id INT, customer_name STRING, region STRING)
- ORDERS (order_id INT, customer_id INT, order_date DATE, amount DECIMAL(10,2))

Write a SQL query that identifies the top 5 customers by total purchase value.

Requirements:
- Include customer_name and region from CUSTOMERS
- Include total_amount (the sum of all order amounts per customer)
- Sort by total_amount descending
- Limit to the top 5 customers only
- Save the final query to /workspace/top_customers.sql
