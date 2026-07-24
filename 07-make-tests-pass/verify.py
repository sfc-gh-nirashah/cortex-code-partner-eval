#!/usr/bin/env python3
"""Runner for Exercise 07 — runs the project's unittest suite.

Usage:
    python verify.py

Runs `python -m unittest discover` inside starter/ and prints PASS or FAIL.
Standard library only — no Snowflake, no pytest.
"""

import pathlib
import subprocess
import sys

STARTER = pathlib.Path(__file__).parent / "starter"


def main() -> None:
    proc = subprocess.run(
        [sys.executable, "-m", "unittest", "discover", "-s", "tests", "-t", ".", "-v"],
        cwd=STARTER,
    )
    if proc.returncode == 0:
        print("PASS: all tests pass")
    else:
        print("FAIL: tests are still failing")
    sys.exit(proc.returncode)


if __name__ == "__main__":
    main()
