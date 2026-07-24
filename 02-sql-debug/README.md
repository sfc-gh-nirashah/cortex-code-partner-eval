# Exercise 2 — Debug a broken SQL query

## Business scenario
An analyst's monthly sales report query is failing and needs to be fixed so the
report can run.

## Setup (once)
Run [`setup.sql`](setup.sql) in a Snowsight worksheet (same tables as Exercise 1;
skip if you already ran it).

## Prompt (paste into Cortex Code, along with the contents of `broken.sql`)

> This Snowflake query is supposed to produce a monthly sales report (revenue and
> order counts by region and month), but it fails to run. The tables live in
> `CORTEX_PARTNER_DEMO.SALES`. Fix all the bugs so it executes correctly, without
> changing the intent of the report.

The starter query is in [`broken.sql`](broken.sql). It has three bugs:
a wrong column name (`amt`), an ambiguous column (`AVG(amount)`), and a typo
(`order_dat`).

## How to verify

Run the fixed query. It should execute without error and return 8 rows —
monthly revenue by region:

| sales_month | region | order_count | total_revenue |
|-------------|--------|-------------|---------------|
| 2024-01-01  | North  | 1           | 45000.00      |
| 2024-01-01  | East   | 1           | 22000.00      |
| 2024-01-01  | West   | 1           | 15000.00      |
| 2024-02-01  | North  | 1           | 18000.00      |
| 2024-02-01  | East   | 1           | 12000.00      |
| 2024-02-01  | West   | 1           |  8500.00      |
| 2024-03-01  | East   | 2           | 13500.00      |
| 2024-03-01  | West   | 2           | 13000.00      |

(Total revenue across all rows = 147,000.)

**Automatic check:** open [`verify.sql`](verify.sql), paste the fixed query into the
marked block, and run it. It prints `PASS` or `FAIL`.

## Why this is valuable to a partner
Shows Cortex Code reading a real Snowflake error, understanding the schema, and
fixing broken SQL — a frequent, high-value task for data teams.
