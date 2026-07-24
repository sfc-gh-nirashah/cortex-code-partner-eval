# Exercise 02 — Fix a broken transformation

**SDLC action:** debug a failing data model.

**Where you'll work:** **[Snowsight]** for setup + verify · **[Cortex Code]** for the fix (give it `starter/broken_model.sql`).

## Business scenario
The transformation behind the monthly sales report is failing, so the report is down.
Fix it and ship it as a view.

## Why this is valuable to a partner
Shows Cortex Code reading real Snowflake errors, understanding the schema, and repairing
a broken model — the everyday debugging loop in a data development workflow.

## Setup (once)
**[Snowsight]** Run the repo's [`setup.sql`](../setup.sql) if you haven't already.

## Prompt (paste into Cortex Code, with the contents of `starter/broken_model.sql`)

> The query in `broken_model.sql` builds a monthly sales report (revenue and order
> counts by region and month) from tables in the current schema, but it
> fails to run. Fix all the bugs and expose the corrected query as a view named
> **`MONTHLY_REGION_REVENUE`** in the same schema. Keep the report's intent unchanged.

The starter has three bugs: a wrong column (`amt`), an ambiguous column (`AVG(amount)`),
and a typo (`order_dat`).

## How to verify
**[Snowsight]** Run [`verify.sql`](verify.sql) — it checks the view returns 8 rows and total revenue of
147,000 (monthly revenue by region), and prints `PASS`/`FAIL`.
