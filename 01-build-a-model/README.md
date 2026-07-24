# Exercise 01 — Build a data model

**SDLC action:** build a reusable analytics artifact.

**Where you'll work:** **[Snowsight]** for setup + verify · **[Cortex Code]** to build the view.

## Business scenario
Analysts keep re-writing the same per-customer revenue rollup. Give them a single
reusable model so every report reads from one consistent source.

## Why this is valuable to a partner
Shows Cortex Code producing a **reusable data artifact** (not a one-off answer) — the
foundational analytics-engineering task in a Snowflake development workflow.

## Setup (once)
**[Snowsight]** Run the repo's [`setup.sql`](../setup.sql) in a Snowsight worksheet, in a schema where you
can create tables. It seeds `CUSTOMERS` (6) and `ORDERS` (10) in your current schema.

## Prompt (paste into Cortex Code)

> Our reports keep re-deriving per-customer revenue from the raw `CUSTOMERS` and
> `ORDERS` tables (in the current schema), and the numbers drift. Create one
> reusable view, **`CUSTOMER_REVENUE`**, that reports each customer's total revenue,
> how many orders they've placed, and their region — so every report can read from a
> single source. Include the columns `customer_name`, `region`, `total_revenue`, and
> `order_count`.

## How to verify
**[Snowsight]** After the view exists, run [`verify.sql`](verify.sql) in your worksheet — it compares
the view's output to the expected result and prints `PASS`/`FAIL`. Expected:

| customer_name | region | total_revenue | order_count |
|---------------|--------|---------------|-------------|
| Acme Corp     | West   | 23500.00      | 2 |
| Globex Ltd    | East   | 29500.00      | 2 |
| Initech       | West   |  3200.00      | 1 |
| Umbrella Co   | North  | 63000.00      | 2 |
| Hooli         | East   | 18000.00      | 2 |
| Pied Piper    | West   |  9800.00      | 1 |
