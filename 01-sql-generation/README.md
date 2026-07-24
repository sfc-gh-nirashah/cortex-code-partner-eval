# Exercise 1 — Generate a SQL query from a business request

## Business scenario
A sales analyst is preparing for a quarterly business review and needs to know the
top 5 customers by total purchase value.

## Setup (once)
Run [`setup.sql`](setup.sql) in a Snowsight worksheet. It creates
`CORTEX_PARTNER_DEMO.SALES` with two seeded tables:

- `CUSTOMERS (customer_id, customer_name, region)` — 6 rows
- `ORDERS (order_id, customer_id, order_date, amount)` — 10 rows

## Prompt (paste into Cortex Code)

> The tables `CUSTOMERS` and `ORDERS` live in `CORTEX_PARTNER_DEMO.SALES`.
> Write a Snowflake SQL query that returns the **top 5 customers by total purchase value**.
> Return three columns named exactly `customer_name`, `region`, and `total_amount`
> (the sum of all order amounts per customer), sorted by `total_amount` descending,
> limited to 5 rows.

## How to verify

Run Cortex Code's query in your worksheet. It should return exactly this:

| customer_name | region | total_amount |
|---------------|--------|--------------|
| Umbrella Co   | North  | 63000.00     |
| Globex Ltd    | East   | 29500.00     |
| Acme Corp     | West   | 23500.00     |
| Hooli         | East   | 18000.00     |
| Pied Piper    | West   |  9800.00     |

(Initech, total 3,200, is correctly excluded.)

**Automatic check:** open [`verify.sql`](verify.sql), paste Cortex Code's query into the
marked block, and run it. It prints `PASS` or `FAIL`.

## Why this is valuable to a partner
Shows Cortex Code turning a plain-English business request into correct, runnable
Snowflake SQL — the most common day-one use case.
