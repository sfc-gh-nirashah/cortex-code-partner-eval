#!/usr/bin/env python3
"""Structural check for the Streamlit + Snowflake app. No Snowflake needed.

Usage:
    python verify.py [path/to/app.py]      # defaults to app.py

Prints PASS or FAIL and exits 0 (pass) or 1 (fail). Standard library only.
"""

import ast
import pathlib
import sys


def fail(msg: str) -> None:
    print(f"FAIL: {msg}")
    sys.exit(1)


def main() -> None:
    path = pathlib.Path(sys.argv[1] if len(sys.argv) > 1 else "app.py")

    if not path.exists():
        fail(f"{path} not found")

    src = path.read_text()

    try:
        ast.parse(src)
    except SyntaxError as e:
        fail(f"Python syntax error: {e}")

    checks = {
        "imports streamlit": "import streamlit" in src or "from streamlit" in src,
        "uses a Snowflake session": (
            "get_active_session" in src or "snowflake" in src.lower()
        ),
        "has a title": "st.title" in src or "st.header" in src,
        "has an interactive filter": any(
            w in src for w in ("st.selectbox", "st.multiselect", "st.radio", "st.slider")
        ),
        "displays data": any(
            call in src
            for call in (
                "st.dataframe",
                "st.table",
                "st.bar_chart",
                "st.line_chart",
                "st.write",
                "st.metric",
            )
        ),
    }

    missing = [name for name, ok in checks.items() if not ok]
    if missing:
        fail("missing required elements: " + ", ".join(missing))

    print("PASS: app.py looks like a valid Streamlit + Snowflake app")
    sys.exit(0)


if __name__ == "__main__":
    main()
