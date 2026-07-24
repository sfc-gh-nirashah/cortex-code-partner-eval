# Exercise 06 — Build a Streamlit app that uses Snowflake

**SDLC action:** build an application.

**Where you'll work:** **[Cortex Code]** to build · **[Terminal]** to verify (Cortex Code's built-in terminal works).

## Business scenario
A product manager wants a simple internal sales dashboard.

## Setup
None to verify. The structural check runs locally with Python 3 — no Snowflake needed.
(Optionally deploy the result as a Streamlit-in-Snowflake app to see it live against the
seeded data.)

## Prompt (paste into Cortex Code)

> Create a Streamlit app `app.py` for a sales dashboard.
> - Connect using the Snowpark active session:
>   `from snowflake.snowpark.context import get_active_session`
> - Query a sales summary (any table, or an inline `SELECT ... FROM VALUES`)
> - Include `st.title("Sales Dashboard")`
> - Add a **region filter** (e.g. `st.selectbox`) that drives the displayed data
> - Show the data with `st.dataframe()` and add a chart (`st.bar_chart()` or `st.line_chart()`)

## How to verify
**[Terminal]** Run the structural check (standard library only — no Snowflake):

```bash
python verify.py app.py
```

It confirms the app compiles and contains the required pieces (imports Streamlit, uses a
Snowflake session, has a title, an interactive filter, and a data display). Prints `PASS`/`FAIL`.

## Why this is valuable to a partner
Shows Cortex Code scaffolding a working **Streamlit + Snowflake app** — a common way
partners build internal data tools.
