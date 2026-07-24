# Exercise 3 — Build a Streamlit app that uses Snowflake

## Business scenario
A product manager wants a simple internal sales dashboard.

## Setup
None. This exercise verifies the app's structure locally and needs no Snowflake
connection. (Optionally, deploy the result as a Streamlit-in-Snowflake app to see
it run live.)

## Prompt (paste into Cortex Code)

> Create a Streamlit application in `app.py` for a sales dashboard.
> - Connect to Snowflake using the Snowpark active session:
>   `from snowflake.snowpark.context import get_active_session`
> - Query a small sales summary (any table, or an inline `SELECT ... FROM VALUES`)
> - Include `st.title("Sales Dashboard")`
> - Display the data with `st.dataframe()` (or `st.table()`)
> - Include at least one chart: `st.bar_chart()` or `st.line_chart()`

## How to verify

Run the structural check (Python standard library only — no Snowflake needed):

```bash
python verify.py path/to/app.py
```

It prints `PASS` when the file compiles and contains the required pieces (imports
Streamlit, uses a Snowflake session, has a title, and displays data). Optionally,
deploy it as a Streamlit-in-Snowflake app to see it render.

## Why this is valuable to a partner
Shows Cortex Code scaffolding a working Streamlit + Snowflake data app from a short
description — a common way partners build internal tools.
