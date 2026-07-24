# Cortex Code — Partner Exercises

A small set of self-contained exercises for evaluating **Snowflake Cortex Code** across
the **software/data development lifecycle (SDLC)** — building, fixing, refactoring,
creating objects, writing code, and shipping an app. Each exercise is a business
scenario, a prompt you give to Cortex Code, and a self-contained way to verify the result.

These are **development-phase** tasks (what a Snowflake app/data developer does), not
"answer-a-business-question" data queries. Every exercise is verified the way ADE-bench
verifies work — **run the artifact and compare it to an expected result** — but with **no
framework**: just a `verify.sql` or `verify.py`.

**You only need:**
- **Cortex Code** (CLI or Snowsight) — to do the exercises.
- A **Snowflake worksheet** — for the SQL exercises (01–04), to seed a small demo dataset and check results.
- **Python 3** — for the local checks in 05 and 06.

## The exercises

| # | Exercise | SDLC action | Verify with |
|---|----------|-------------|-------------|
| 01 | [Build a data model](01-build-a-model/) | Build a reusable view | `verify.sql` (compare output) |
| 02 | [Fix a broken transformation](02-fix-a-transformation/) | Debug a failing model | `verify.sql` (compare output) |
| 03 | [Refactor a model](03-refactor-a-model/) | Refactor, preserve behavior | `verify.sql` (compare output) |
| 04 | [Create a SQL UDF](04-create-a-udf/) | Build a reusable object | `verify.sql` (call + check) |
| 05 | [Python utility + tests](05-python-merge-helper/) | Generate tested code | `python verify.py` |
| 06 | [Streamlit app](06-streamlit-app/) | Build an application | `python verify.py` |

## How to use

1. **Once:** run [`setup.sql`](setup.sql) in a Snowsight worksheet — it creates
   `CORTEX_PARTNER_DEMO.SALES` with a small seeded dataset (used by 01–04).
2. Pick an exercise folder and open its `README.md`.
3. Paste the exercise's **Prompt** into Cortex Code and let it do the work.
4. **Verify:**
   - SQL exercises (01–04): run the folder's `verify.sql` in your worksheet → `PASS`/`FAIL`.
   - Code exercises (05–06): run `python verify.py <file>` → `PASS`/`FAIL`.

That's the whole loop: **scenario → prompt → run the artifact → verify.**

## Cleanup

```sql
DROP DATABASE IF EXISTS CORTEX_PARTNER_DEMO;
```
