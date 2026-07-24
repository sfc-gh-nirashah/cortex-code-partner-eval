# Exercise 07 — Make the failing test suite pass (multi-file) 🚩

**SDLC action:** the real agent loop — read a project, change multiple files, run tests,
iterate until green. **This is the flagship exercise.**

**Where you'll work:** **[Cortex Code]** to implement (point it at `starter/`) · **[Terminal]** to verify.

## Business scenario
You've inherited a small `salespipe` Python package that transforms and reports on sales
data. Several functions aren't implemented yet, so its test suite is failing. Get it green.

## Why this is valuable to a partner
This is what a coding **agent** does that autocomplete and query tools can't: understand a
small codebase, implement across **multiple files** with a real dependency between them, and
**run the tests to confirm** — the build → run → fix loop at the heart of developer
productivity.

## Setup
None beyond Python 3. No Snowflake needed. The starter project is in [`starter/`](starter/):

```
starter/
  salespipe/
    transforms.py   # enrich(), filter_by_region()  — not implemented
    report.py       # revenue_by_region(), order_count_by_region()  — not implemented
  tests/
    test_transforms.py
    test_report.py
```

## Prompt (paste into Cortex Code, pointed at the `starter/` folder)

> The `salespipe` package has a failing test suite. Implement the unfinished functions in
> `salespipe/transforms.py` and `salespipe/report.py` so that all tests pass. Run the tests
> to confirm. Don't change the tests.

The `report` functions depend on `transforms.enrich`, so the work spans multiple files and
has to stay consistent.

## How to verify
**[Terminal]** From this exercise folder:

```bash
python verify.py
```

(or, inside `starter/`: `python -m unittest discover -s tests`). It runs the suite and prints
`PASS` when every test is green.
