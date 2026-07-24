# Exercise 04 — Build a 2-layer transformation pipeline

**SDLC action:** compose dependent models (staging → mart).

**Where you'll work:** **[Snowsight]** for setup + verify · **[Cortex Code]** to build the pipeline.

## Business scenario
Instead of one big monolithic query, build the monthly revenue report as a proper
**2-layer pipeline**: a staging model that enriches raw orders, and a mart model that
aggregates on top of it. This is how analytics-engineering teams keep transformations
modular and reusable.

## Setup (once)
**[Snowsight]** Run the repo's [`setup.sql`](../setup.sql) if you haven't already.

## Prompt (paste into Cortex Code)

> In the current schema, build a two-layer pipeline of views:
> 1. **`STG_CUSTOMER_ORDERS`** — one row per order, enriched with the order's
>    `customer_name` and `region` (from `CUSTOMERS`).
> 2. **`MART_MONTHLY_REVENUE`** — monthly `total_revenue` and `order_count` by region.
>    It **must be built on top of `STG_CUSTOMER_ORDERS`**, not the raw tables.

## How to verify
**[Snowsight]** Run [`verify.sql`](verify.sql). It checks three things and prints `PASS`/`FAIL`:
- `STG_CUSTOMER_ORDERS` exists and has 10 rows (one per order),
- `MART_MONTHLY_REVENUE` returns 8 rows with total revenue of 147,000,
- the mart's definition actually **reads from the staging view** (via `GET_DDL`) — proving
  it's a real pipeline, not two disconnected queries.

## Why this is valuable to a partner
This is the core analytics-engineering pattern (à la dbt): the agent composes **dependent
models** and reasons about layering — not just a single query. The verify even confirms the
dependency, so it demonstrates Cortex Code built a *pipeline*, not just an answer.
