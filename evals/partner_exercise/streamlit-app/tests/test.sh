#!/bin/bash

# Structural verifier: the app must compile and contain the required pieces.
# Same shape as the shipped simple_tests verifiers (compile + grep -> reward.txt).

APP=/workspace/app.py

# 1. File must exist
if [ ! -f "$APP" ]; then
    echo "FAIL: app.py not found in /workspace"
    echo "0" > /logs/verifier/reward.txt
    exit 0
fi

# 2. Must compile without syntax errors
python3 -m py_compile "$APP" 2>/tmp/compile_check.txt
if [ $? -ne 0 ]; then
    echo "FAIL: app.py has Python syntax errors:"
    cat /tmp/compile_check.txt
    echo "0" > /logs/verifier/reward.txt
    exit 0
fi

# 3. Must import streamlit
if ! grep -qE "import streamlit|from streamlit" "$APP"; then
    echo "FAIL: app.py does not import streamlit"
    echo "0" > /logs/verifier/reward.txt
    exit 0
fi

# 4. Must reference Snowflake (session or connector)
if ! grep -qE "get_active_session|snowflake|SnowflakeConnection" "$APP"; then
    echo "FAIL: app.py does not reference Snowflake"
    echo "0" > /logs/verifier/reward.txt
    exit 0
fi

# 5. Must have a title
if ! grep -qE "st\.title|st\.header" "$APP"; then
    echo "FAIL: app.py missing st.title() or st.header()"
    echo "0" > /logs/verifier/reward.txt
    exit 0
fi

# 6. Must display data
if ! grep -qE "st\.dataframe|st\.table|st\.bar_chart|st\.line_chart|st\.write|st\.metric" "$APP"; then
    echo "FAIL: app.py missing a data display call (st.dataframe, st.bar_chart, etc.)"
    echo "0" > /logs/verifier/reward.txt
    exit 0
fi

echo "PASS: app.py is a valid Streamlit + Snowflake application"
echo "1" > /logs/verifier/reward.txt
