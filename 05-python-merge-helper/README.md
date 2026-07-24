# Exercise 05 — Write a Python utility (with tests)

**SDLC action:** generate correct, tested code.

**Where you'll work:** **[Cortex Code]** to build · **[Terminal]** to verify (Cortex Code's built-in terminal works).

## Business scenario
Your data-loading scripts hand-write Snowflake `MERGE` (upsert) statements and keep
making typos. Build a small helper that generates them consistently.

## Setup
None. This runs locally with Python 3 — no Snowflake connection needed.

## Prompt (paste into Cortex Code)

> Create a Python file `merge_helper.py` with a function:
>
> `build_merge(target_table, source_table, key_columns, update_columns) -> str`
>
> It returns a Snowflake `MERGE` statement that upserts from the source into the target:
> - `MERGE INTO <target_table> AS t USING <source_table> AS s`
> - `ON` the key columns joined with `AND` (e.g. `t.id = s.id`)
> - `WHEN MATCHED THEN UPDATE SET` each update column (e.g. `t.name = s.name`)
> - `WHEN NOT MATCHED THEN INSERT (...) VALUES (...)` covering key + update columns
>
> Keep it dependency-free (standard library only).

## How to verify
**[Terminal]** Run the check (standard library only — no Snowflake):

```bash
python verify.py merge_helper.py
```

It calls `build_merge("TARGET_T","SOURCE_S",["id"],["name","amount"])` and confirms the
generated statement contains the required clauses. Prints `PASS`/`FAIL`.

## Why this is valuable to a partner
Shows Cortex Code generating **working, verifiable Python** from a spec — code an agent
can be trusted to produce because it's checked objectively, not eyeballed.
