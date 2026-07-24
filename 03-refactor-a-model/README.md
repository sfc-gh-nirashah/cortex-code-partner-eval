# Exercise 03 — Refactor a model without changing its output

**SDLC action:** refactor for readability while preserving behavior.

## Business scenario
A regional-revenue query works but is hard to maintain (correlated subquery inside a
wrapper). Clean it up and ship it as a view — same numbers, better code.

## Setup (once)
Run the repo's [`setup.sql`](../setup.sql) if you haven't already.

## Prompt (paste into Cortex Code, with the contents of `starter/messy_model.sql`)

> The query in `messy_model.sql` returns total revenue per region from tables in
> `CORTEX_PARTNER_DEMO.SALES`. Refactor it into clean, readable SQL (a simple join +
> aggregation) and expose it as a view named **`REGION_REVENUE`** in that schema.
> The output must be identical to the original.

## How to verify
Run [`verify.sql`](verify.sql) — it checks the refactored view returns exactly the
expected 3 rows and prints `PASS`/`FAIL`:

| region | total_revenue |
|--------|---------------|
| West   | 36500.00 |
| East   | 47500.00 |
| North  | 63000.00 |

## Why this is valuable to a partner
Shows Cortex Code improving code quality **without regressions** — a core maintenance
task, and exactly what a coding agent (vs. autocomplete) is good at.
