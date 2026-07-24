# Cortex Code — Partner Exercises

A small set of partner-facing exercises for **Snowflake Cortex Code**. Each exercise is a
prompt plus a way to verify whether Cortex Code completed it, run through the existing
[`cortex-code-eval`](https://github.com/snowflakedb/cortex-code-eval) framework.

Each exercise follows the same simple shape:

```
Exercise  →  Prompt (instruction.md)  →  Verification (tests/test.sh writes reward.txt)
```

No new framework, scoring, or abstractions — just eval content that plugs into the repo.

---

## Exercise 1 — Generate a SQL query (`sql-generation`)

- **Business scenario:** A sales analyst preparing a quarterly review needs the top 5 customers by total purchase value.
- **Prompt:** Given `CUSTOMERS` and `ORDERS` tables (seeded per run), write a query that returns the top 5 customers by total order amount and save it to `/workspace/top_customers.sql`.
- **Verification:** `tests/test.sh` executes the query against the seeded scratch schema and passes if it returns exactly 5 rows with the correct top customer.
- **Files:** `task.toml`, `instruction.md`, `environment/setup.sh` (seeds the tables), `tests/test.sh`.
- **Why it's valuable:** Shows Cortex Code translating a plain business request into correct, runnable Snowflake SQL.

## Exercise 2 — Debug a broken SQL query (`sql-debug`)

- **Business scenario:** An analyst's monthly sales report query is failing and needs fixing.
- **Prompt:** Fix the bugs in `/workspace/broken.sql` so it runs and returns monthly revenue by region.
- **Verification:** `tests/test.sh` executes the fixed query and passes if it runs without error and returns grouped rows.
- **Files:** `task.toml`, `instruction.md`, `starter/broken.sql` (the broken query), `environment/setup.sh` (seeds the tables), `tests/test.sh`.
- **Why it's valuable:** Shows Cortex Code diagnosing and fixing real Snowflake SQL errors.

## Exercise 3 — Build a Streamlit app (`streamlit-app`)

- **Business scenario:** A product manager wants a simple sales dashboard.
- **Prompt:** Create `/workspace/app.py`, a Streamlit app that uses the Snowpark active session and displays a sales summary with a title, a table, and a chart.
- **Verification:** `tests/test.sh` checks the app compiles and contains the required pieces (imports Streamlit, references Snowflake, has a title and a data display).
- **Files:** `task.toml`, `instruction.md`, `tests/test.sh`.
- **Why it's valuable:** Shows Cortex Code scaffolding a working Streamlit + Snowflake app.

---

## Running the exercises

These run inside the `cortex-code-eval` framework. Copy the contents of `evals/` into your
`cortex-code-eval` checkout's `evals/` directory, then run from the repo root:

```bash
# streamlit-app needs only an eval (model-auth) connection.
# sql-generation and sql-debug also need an admin connection (they seed a scratch schema).

uv run cortex-eval run --config evals/partner_exercise.yaml \
  -c <eval_connection> -a <admin_connection>

# Run a single exercise:
uv run cortex-eval run --config evals/partner_exercise.yaml \
  -c <eval_connection> -a <admin_connection> -i "streamlit-app"

# See results:
uv run cortex-eval analyze summary jobs/<timestamp>
```

## Layout

```
evals/
  partner_exercise.yaml
  partner_exercise/
    sql-generation/   task.toml  instruction.md  environment/setup.sh  tests/test.sh
    sql-debug/        task.toml  instruction.md  starter/broken.sql  environment/setup.sh  tests/test.sh
    streamlit-app/    task.toml  instruction.md  tests/test.sh
```
