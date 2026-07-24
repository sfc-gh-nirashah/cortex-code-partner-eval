#!/bin/bash
# Verify the fixed query executes and returns grouped rows.
# The bugs in broken.sql prevent execution, so "runs + returns rows" is
# the clear success signal.

python3 << 'PY'
from pathlib import Path

reward = "0"
try:
    from cortex_code_eval.eval_container_tools.connections import get_snowflake_connection

    sql = Path("/workspace/broken.sql").read_text().strip()
    cur = get_snowflake_connection().cursor()
    cur.execute(sql)  # raises if any bug remains
    rows = cur.fetchall()
    cols = [c[0].upper() for c in cur.description]

    # Success = runs without error, returns rows, and groups by region.
    if len(rows) > 0 and "REGION" in cols:
        reward = "1"
    print(f"rows={len(rows)} cols={cols}")
except Exception as e:
    print(f"error: {e}")

Path("/logs/verifier/reward.txt").write_text(reward)
print("PASS" if reward == "1" else "FAIL")
PY
