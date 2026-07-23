Build a simple internal sales dashboard for a product manager.

Create a Streamlit application at /workspace/app.py that:

1. Connects to Snowflake using the active Snowpark session:
   from snowflake.snowpark.context import get_active_session

2. Queries a sales summary — use any available table or write a simple
   inline query. A mock query like the following is acceptable:
   SELECT * FROM VALUES (1,'Jan',12000),(2,'Feb',18500),(3,'Mar',9800)
   AS t(month_num, month_name, revenue)

3. Displays the data in the app

Requirements:
- Use streamlit (import streamlit as st)
- Use get_active_session() from snowflake.snowpark.context for Snowflake access
- Include st.title("Sales Dashboard")
- Display data with st.dataframe() or st.table()
- Include at least one chart: st.bar_chart() or st.line_chart()
- Save the app to /workspace/app.py
