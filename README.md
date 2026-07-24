# Cortex Code — Partner Exercises

A small set of self-contained exercises for trying **Snowflake Cortex Code**. Each
exercise is a real business scenario, a prompt you give to Cortex Code, and a clear
way to check whether it succeeded.

**No special framework required.** You only need:

- **Cortex Code** (CLI or Snowsight) — to do the exercises.
- A **Snowflake account** with a worksheet — for the two SQL exercises (to seed a
  tiny demo dataset and run the queries).
- **Python 3** — only for the optional structural check in the Streamlit exercise.

## The exercises

| # | Exercise | Capability | Verify with |
|---|----------|------------|-------------|
| 1 | [SQL generation](01-sql-generation/) | Generate a Snowflake query from a business request | expected result + `verify.sql` |
| 2 | [SQL debugging](02-sql-debug/) | Fix a broken Snowflake query | expected result + `verify.sql` |
| 3 | [Streamlit app](03-streamlit-app/) | Build a Streamlit + Snowflake app | `python verify.py` |

## How to use

1. Pick an exercise folder and open its `README.md`.
2. (Exercises 1–2) Run the folder's `setup.sql` once in a Snowsight worksheet — it
   creates `CORTEX_PARTNER_DEMO.SALES` with a small seeded dataset.
3. Paste the exercise's **Prompt** into Cortex Code and let it do the work.
4. **Verify** using the steps in the exercise README:
   - SQL exercises: compare the output to the expected result, or paste the query
     into `verify.sql` for an automatic `PASS`/`FAIL`.
   - Streamlit: run `python verify.py app.py`.

That's the whole loop: **scenario → prompt → verify.**

## Cleanup

When finished, drop the demo data:

```sql
DROP DATABASE IF EXISTS CORTEX_PARTNER_DEMO;
```
