# Cortex Code — Partner Exercises

![exercises](https://img.shields.io/badge/exercises-8-2b6cb0) ![setup](https://img.shields.io/badge/setup-self--contained-2f855a) ![framework](https://img.shields.io/badge/framework-none-718096) ![verifiers](https://img.shields.io/badge/verifiers-validated-2f855a)

A set of self-contained exercises for evaluating **Snowflake Cortex Code** across the
**software/data development lifecycle (SDLC)** — building, fixing, refactoring, composing
pipelines, writing code, debugging, and shipping an app. Each exercise is a business
scenario, a prompt you give to Cortex Code, and a self-contained way to verify the result.

These are **development-phase** tasks (what a Snowflake app/data developer does), not
"answer-a-business-question" data queries. Every exercise is verified simply —
**run the artifact and compare it to an expected result** — with **no special framework**:
just a `verify.sql` or `verify.py`.

## How it works

```
scenario  →  prompt  →  Cortex Code (writes + runs + iterates)  →  artifact  →  verify  →  PASS / FAIL
```

```
Easy ─────────────────────────────────────────────────────────▶ Hard
 01 build · 02 fix · 03 refactor · 04 pipeline · 05 python · 06 streamlit · 07 tests 🚩 · 08 diagnose
```

## Prerequisites

- **Cortex Code** — installed and connected to Snowflake (see Snowflake's [Cortex Code docs](https://docs.snowflake.com/en/user-guide/cortex-code/cortex-code)).
- **A Snowflake worksheet** with a role that can create tables/views in some schema — for the SQL exercises (1–4, 8). No `CREATE DATABASE` needed; any schema you can write to works.
- **Python 3** — for the code exercises (5, 6, 7). If `python` isn't found, use `python3`.

No special framework or containers required.

## Where you run things

Each exercise step is tagged with where to run it:

- **[Cortex Code]** — paste the prompt; the agent does the work. Since it's connected to Snowflake, it can create the view/object directly (if it only prints SQL, run that in your worksheet). For the "fix/refactor/diagnose" exercises, give it the `starter/*.sql` file (open it, or paste its contents).
- **[Snowsight]** — run `setup.sql` (once) and each SQL exercise's `verify.sql`.
- **[Terminal]** — run `python verify.py` for the code exercises. Cortex Code's built-in terminal works.

*Cortex Code can do all of it end-to-end (it has both SQL and a terminal) — Snowsight and the terminal are just where you'd naturally check results.*

---

## Choose a path

Pick based on how much time you have and how deep you want to go — simple combo to full showcase.

| Path | Best for | Exercises | Approx. time |
|------|----------|-----------|--------------|
| **Quick taste** | A first look (2 prompts) | 1, 2 | ~20 min |
| **Developer combo** | See the everyday range | 1 – 6 | ~1.5 hrs |
| **Full agent showcase** | See real SDLC power | 1 – 8 | ~2.5 hrs |

**Short on time but want the "aha"?** Do **Exercise 7** on its own (~30 min) — it's the one
that best shows Cortex Code working like a developer, not autocomplete.

---

## All exercises

Ordered simple → complex. The **Prompt** column is the gist — the full prompt (with exact object names) is in each exercise's `README.md`.

| # | Exercise | Prompt | What it proves | Complexity | Time | Verify |
|---|----------|--------|----------------|-----------|------|--------|
| 1 | [Build a data model](01-build-a-model/) | *"Reports keep re-deriving per-customer revenue. Create a reusable view `CUSTOMER_REVENUE` (customer_name, region, total_revenue, order_count)."* | Generate a reusable artifact from a business need | Easy | ~10 min | `verify.sql` |
| 2 | [Fix a broken transformation](02-fix-a-transformation/) | *"`broken_model.sql` powers the monthly report but fails. Fix the bugs and expose it as view `MONTHLY_REGION_REVENUE`."* | Read errors, repair a failing model | Easy | ~10 min | `verify.sql` |
| 3 | [Refactor a model](03-refactor-a-model/) | *"`messy_model.sql` works but is hard to maintain. Refactor into clean view `REGION_REVENUE` — identical output."* | Improve code without regressions | Medium | ~15 min | `verify.sql` |
| 4 | [Build a 2-layer pipeline](04-build-a-pipeline/) | *"Build `STG_CUSTOMER_ORDERS` (enriched orders) and `MART_MONTHLY_REVENUE` on top of it — not the raw tables."* | Compose dependent models (staging → mart) | Medium | ~20 min | `verify.sql` |
| 5 | [Python utility + tests](05-python-merge-helper/) | *"Create `merge_helper.py` with `build_merge(target, source, keys, update_cols)` that returns a parameterized Snowflake MERGE statement."* | Generate verifiable, dependency-free code | Medium | ~15 min | `python verify.py` |
| 6 | [Streamlit app](06-streamlit-app/) | *"Build `app.py` — a Streamlit sales dashboard using the Snowpark active session, with a region filter and a chart."* | Build an interactive app | Medium | ~20 min | `python verify.py` |
| 7 | [Make the test suite pass](07-make-tests-pass/) 🚩 | *"The `salespipe` package has a failing test suite. Implement the unfinished functions in `transforms.py` and `report.py` so all tests pass."* | The real agent loop: multi-file changes, run tests, iterate | Hard | ~30 min | `python verify.py` |
| 8 | [Diagnose by running it](08-diagnose-by-running/) | *"Revenue by region looks wrong — North is doubled. Investigate the data, find the root cause, and fix it as view `REGION_REVENUE_FIXED`."* | Investigate live data to find a bug (tool use) | Hard | ~25 min | `verify.sql` |

---

## How to use

1. **Once:** pick a database + schema you can create tables in (set it in the Snowsight
   worksheet context, or `USE SCHEMA <your_db>.<your_schema>;`), then run [`setup.sql`](setup.sql).
   It seeds `CUSTOMERS` and `ORDERS` in that schema (used by the SQL exercises). No
   `CREATE DATABASE` needed. *(Exercise 8 also runs `setup_08.sql` in the same schema.)*
2. Open an exercise folder's `README.md`.
3. Paste its **Prompt** into Cortex Code and let it work.
4. **Verify:**
   - SQL exercises (1–4, 8): run the folder's `verify.sql` in your worksheet → `PASS`/`FAIL`.
   - Code exercises (5, 6, 7): run `python verify.py [file]` → `PASS`/`FAIL`.

That's the whole loop: **scenario → prompt → run the artifact → verify.**

> Each `verify.sql` / `verify.py` shows the expected result inline — that's intentional (it's a check, not a hidden test).

### What a pass looks like

SQL exercises (Snowsight):
```
RESULT
------
PASS
```
Code exercises (terminal):
```
PASS: all tests pass
```

### Track your results

Record PASS/FAIL per exercise in [`SCORECARD.md`](SCORECARD.md). To run all three code
checks at once (after you've created their files): `bash run-checks.sh`.

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| SQL: *object does not exist* / verify fails right away | You're not in the schema where `setup.sql` ran. Set the worksheet's database + schema (or `USE SCHEMA <db>.<schema>;`). |
| SQL: *no active warehouse* | Select a warehouse in the worksheet (top-right). |
| Cortex Code didn't create the object | It may have only printed the SQL — copy it into your worksheet and run it. |
| `python: command not found` | Use `python3` instead of `python`. |
| Cortex Code can't reach Snowflake | Confirm Cortex Code is signed in / connected to your account. |

## Cleanup

Drop the demo objects from the schema you used:

```sql
DROP VIEW IF EXISTS CUSTOMER_REVENUE;
DROP VIEW IF EXISTS MONTHLY_REGION_REVENUE;
DROP VIEW IF EXISTS REGION_REVENUE;
DROP VIEW IF EXISTS STG_CUSTOMER_ORDERS;
DROP VIEW IF EXISTS MART_MONTHLY_REVENUE;
DROP VIEW IF EXISTS REGION_REVENUE_FIXED;
DROP TABLE IF EXISTS CUSTOMER_REGION_LOOKUP;
DROP TABLE IF EXISTS CUSTOMERS;
DROP TABLE IF EXISTS ORDERS;
```
