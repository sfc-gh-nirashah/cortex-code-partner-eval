#!/bin/bash
# Verify the generated query returns the correct top-5 result.
# Uses the framework's injected connection helper + scratch schema.

python3 << 'PY'
from pathlib import Path

reward = "0"
try:
    from cortex_code_eval.eval_container_tools.connections import get_snowflake_connection

    sql = Path("/workspace/top_customers.sql").read_text().strip()
    cur = get_snowflake_connection().cursor()
    cur.execute(sql)
    rows = cur.fetchall()
    cols = [c[0].upper() for c in cur.description]
    name_idx = next((i for i, c in enumerate(cols) if "NAME" in c or "CUSTOMER" in c), 0)

    # Success = exactly 5 rows and Umbrella Co (highest total) is first.
    if len(rows) == 5 and "UMBRELLA" in str(rows[0][name_idx]).upper():
        reward = "1"
    print(f"rows={len(rows)} top={rows[0] if rows else None}")
except Exception as e:
    print(f"error: {e}")

Path("/logs/verifier/reward.txt").write_text(reward)
print("PASS" if reward == "1" else "FAIL")
PY
