"""Verifier for the SQL generation exercise.

Pattern: snova-verifier-example / setup-script-example
Fixtures: snowflake_cursor, scratch_schema, scratch_database from
          cortex_code_eval.eval_container_tools.conftest (connections.py:25-81)

Expected answer (seeded data):
  1. Umbrella Co  — 63 000.00  (orders 5 + 9)
  2. Globex Ltd   — 29 500.00  (orders 3 + 8)
  3. Acme Corp    — 23 500.00  (orders 1 + 2)
  4. Hooli        — 18 000.00  (orders 6 + 10)
  5. Pied Piper   —  9 800.00  (order 7)
  6. Initech      —  3 200.00  (order 4)  ← must NOT appear
"""

from pathlib import Path

import pytest

pytest_plugins = ["cortex_code_eval.eval_container_tools.conftest"]

QUERY_FILE = Path("/workspace/top_customers.sql")


def test_query_file_exists():
    """Agent must write the query to /workspace/top_customers.sql."""
    assert QUERY_FILE.exists(), "top_customers.sql not found in /workspace"


def test_query_file_has_content():
    """Query file must not be empty."""
    content = QUERY_FILE.read_text().strip()
    assert len(content) > 10, "top_customers.sql is empty"


def test_query_returns_exactly_5_rows(snowflake_cursor):
    """Executing the query must return exactly 5 rows (LIMIT 5)."""
    sql = QUERY_FILE.read_text().strip()
    snowflake_cursor.execute(sql)
    rows = snowflake_cursor.fetchall()
    assert len(rows) == 5, (
        f"Expected 5 rows, got {len(rows)}. "
        "Verify the query has a LIMIT 5 clause."
    )


def test_top_customer_is_umbrella(snowflake_cursor):
    """Umbrella Co has the highest total (63 000) and must be row 1."""
    sql = QUERY_FILE.read_text().strip()
    snowflake_cursor.execute(sql)
    cols = [col[0].upper() for col in snowflake_cursor.description]
    rows = snowflake_cursor.fetchall()

    name_idx = next(
        (i for i, c in enumerate(cols) if "NAME" in c or "CUSTOMER" in c),
        None,
    )
    assert name_idx is not None, (
        f"No customer name column found in result. Columns: {cols}"
    )
    assert "UMBRELLA" in str(rows[0][name_idx]).upper(), (
        f"Expected Umbrella Co as top customer, got: {rows[0][name_idx]}"
    )


def test_initech_not_in_results(snowflake_cursor):
    """Initech (total 3 200) must not appear in the top 5."""
    sql = QUERY_FILE.read_text().strip()
    snowflake_cursor.execute(sql)
    cols = [col[0].upper() for col in snowflake_cursor.description]
    rows = snowflake_cursor.fetchall()

    name_idx = next(
        (i for i, c in enumerate(cols) if "NAME" in c or "CUSTOMER" in c),
        None,
    )
    if name_idx is not None:
        names = [str(row[name_idx]).upper() for row in rows]
        assert not any("INITECH" in n for n in names), (
            "Initech should not appear in the top 5 (total = 3 200)"
        )
