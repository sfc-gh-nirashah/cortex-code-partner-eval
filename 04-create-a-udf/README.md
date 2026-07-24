# Exercise 04 — Create a Snowflake object (SQL UDF)

**SDLC action:** build a reusable database object with business logic.

## Business scenario
Different reports classify customers into spend tiers inconsistently. Standardize the
logic in one reusable function.

## Setup (once)
Run the repo's [`setup.sql`](../setup.sql) if you haven't already. (The function itself
needs no data, but this keeps you in the right schema.)

## Prompt (paste into Cortex Code)

> In `CORTEX_PARTNER_DEMO.SALES`, create a SQL UDF named **`customer_tier`** that takes
> one numeric argument (total spend) and returns a STRING tier:
> - `'Gold'`   when spend >= 30000
> - `'Silver'` when spend >= 10000 (and < 30000)
> - `'Bronze'` otherwise

## How to verify
Run [`verify.sql`](verify.sql) — it calls the function with sample values and checks the
tier boundaries, printing `PASS`/`FAIL`:

| input | expected |
|-------|----------|
| 63000 | Gold |
| 30000 | Gold |
| 18000 | Silver |
| 10000 | Silver |
|  3200 | Bronze |

## Why this is valuable to a partner
Shows Cortex Code creating a **reusable Snowflake object** that encapsulates business
logic — a common way teams standardize rules across a Snowflake codebase.
