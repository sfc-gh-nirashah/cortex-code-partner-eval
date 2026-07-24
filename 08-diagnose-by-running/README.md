# Exercise 08 — Diagnose a bug by investigating the data

**SDLC action:** debug by *running and inspecting* — not just reading code.

**Where you'll work:** **[Snowsight]** for setup + verify · **[Cortex Code]** to investigate + fix (give it `starter/revenue_by_region.sql`).

## Business scenario
The regional revenue report shows the **North** region's revenue as **doubled**. The query
"looks fine," so the bug isn't obvious from the SQL alone — you have to look at the actual
data to find the root cause.

## Setup (once)
1. **[Snowsight]** Run the repo's [`setup.sql`](../setup.sql) if you haven't already.
2. **[Snowsight]** Run this exercise's [`setup_08.sql`](setup_08.sql) — it adds a `CUSTOMER_REGION_LOOKUP`
   table (which contains the problem).

## Prompt (paste into Cortex Code, with the contents of `starter/revenue_by_region.sql`)

> The query in `revenue_by_region.sql` reports total revenue per region from tables
> in the current schema, but the North total is coming out doubled. The SQL looks
> correct. Investigate the underlying data to find the root cause, then produce a corrected
> result as a view named **`REGION_REVENUE_FIXED`** with the right per-region totals.

The root cause is not visible in the query text — the agent has to query the tables (e.g.
inspect `CUSTOMER_REGION_LOOKUP`) to discover a duplicate row causing a fan-out join.

## How to verify
**[Snowsight]** Run [`verify.sql`](verify.sql). It checks `REGION_REVENUE_FIXED` returns the correct totals
and prints `PASS`/`FAIL`:

| region | total_revenue |
|--------|---------------|
| West   | 36500.00 |
| East   | 47500.00 |
| North  | 63000.00 |

## Why this is valuable to a partner
This shows Cortex Code's **unique edge**: it's connected to your warehouse and can
**investigate the actual data** to diagnose a problem — a fan-out from a duplicate lookup row —
that no static code reading or text-to-SQL tool would catch. Real debugging, not pattern-matching.
