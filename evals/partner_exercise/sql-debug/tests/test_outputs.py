"""Verifier for the SQL debugging exercise.

Pattern: same as sql-generation — pytest + conftest fixtures.

broken.sql has three bugs the agent must fix:
  1. o.amt      → o.amount       (column does not exist)
  2. AVG(amount) → AVG(o.amount) (ambiguous column reference in join)
  3. o.order_dat → o.order_date  (typo in column name)

A correctly fixed query aggregates ORDERS JOIN CUSTOMERS by month + region
and returns rows only for 2024-01-01 onwards.
"""

from pathlib import Path

import pytest

pytest_plugins = ["cortex_code_eval.eval_container_tools.conftest"]

QUERY_FILE = Path("/workspace/broken.sql")


def test_query_file_exists():
    """broken.sql must still exist after the agent edits it."""
    assert QUERY_FILE.exists(), "broken.sql not found in /workspace"


def test_query_executes_without_error(snowflake_cursor):
    """The fixed query must execute without raising an exception."""
    sql = QUERY_FILE.read_text().strip()
    # raises snowflake.connector.errors.ProgrammingError on any remaining bug
    snowflake_cursor.execute(sql)


def test_query_returns_rows(snowflake_cursor):
    """The fixed query must return at least one row from the seeded data."""
    sql = QUERY_FILE.read_text().strip()
    snowflake_cursor.execute(sql)
    rows = snowflake_cursor.fetchall()
    assert len(rows) > 0, (
        "Query returned no rows. Check that the WHERE clause is not too restrictive."
    )


def test_result_contains_region_column(snowflake_cursor):
    """Result must include a REGION column (from the CUSTOMERS join)."""
    sql = QUERY_FILE.read_text().strip()
    snowflake_cursor.execute(sql)
    cols = [col[0].upper() for col in snowflake_cursor.description]
    assert "REGION" in cols, (
        f"Expected a REGION column in results. Got: {cols}"
    )


def test_result_contains_revenue_column(snowflake_cursor):
    """Result must include a revenue/total column (SUM of amounts)."""
    sql = QUERY_FILE.read_text().strip()
    snowflake_cursor.execute(sql)
    cols = [col[0].upper() for col in snowflake_cursor.description]
    has_revenue = any(
        kw in c for c in cols for kw in ("REVENUE", "TOTAL", "AMOUNT", "SUM")
    )
    assert has_revenue, (
        f"Expected a revenue/total column in results. Got: {cols}"
    )
