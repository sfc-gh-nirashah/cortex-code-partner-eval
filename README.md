# Cortex Code — Partner Evaluation Exercise (Slice 1)

A small, partner-facing evaluation exercise for **Snowflake Cortex Code**, built on the
existing [`cortex-code-eval`](https://github.com/snowflakedb/cortex-code-eval) Harbor
framework. It contains **3 Snowflake-native prompts** that demonstrate common Cortex Code
capabilities and score them deterministically using the framework's standard verifier
pattern (`reward.txt` → `passed = reward >= 1.0`).

> This repo adds **only** eval content (tasks + config). It introduces no new framework
> code, scoring, or architecture. It runs inside a `cortex-code-eval` checkout.

## Exercises

| Task | Capability | Verification | Connections |
| --- | --- | --- | --- |
| `sql-generation` | Generate a Snowflake SQL query from a business request | pytest executes the query against seeded scratch tables; asserts top‑5 result | eval + admin |
| `sql-debug` | Fix a broken Snowflake SQL query (3 bugs) | pytest executes the fixed query; asserts it runs and returns the right shape | eval + admin |
| `streamlit-app` | Build a Streamlit app that uses Snowflake | structural check: compiles + imports streamlit/snowflake + has title & data display | eval only |

## Layout

```
evals/
  partner_exercise.yaml          # run config (simplified skill-eval format)
  partner_exercise/
    _shared/tests/test.sh        # shared pytest runner (pytest -> reward.txt)
    sql-generation/
      task.toml
      instruction.md
      environment/setup.sh       # seeds CUSTOMERS + ORDERS in the scratch schema
      tests/test_outputs.py
    sql-debug/
      task.toml
      instruction.md
      starter/broken.sql         # uploaded to /workspace, fixed in place by the agent
      environment/setup.sh
      tests/test_outputs.py
    streamlit-app/
      task.toml
      instruction.md
      tests/test.sh              # deterministic structural verifier
```

## Usage

These tasks run inside the `cortex-code-eval` framework. Copy the contents of `evals/`
into your `cortex-code-eval` checkout's `evals/` directory, then:

```bash
# From the cortex-code-eval repo root.
# streamlit-app needs only an eval (model-auth) connection.
# sql-generation and sql-debug additionally need an admin connection (scratch schema).

uv run cortex-eval run --config evals/partner_exercise.yaml \
  -c <eval_connection_name> \
  -a <admin_connection_name>

# Fast iteration — run one exercise, one attempt:
uv run cortex-eval run --config evals/partner_exercise.yaml \
  -c <eval_conn> -a <admin_conn> -i "streamlit-app" --n-attempts 1

# Analyze results:
uv run cortex-eval analyze summary jobs/<timestamp>
```

## Validation checklist (before sharing broadly)

1. Run `streamlit-app` first (`-i "streamlit-app"`) — no admin connection needed; fastest proof the harness works.
2. Confirm `analyze summary` shows PASS and Pass@1 = 1.0.
3. Run `sql-generation` with scratch connections; confirm the seed succeeds and the query executes.
4. Temporarily break an assertion (e.g. `assert len(rows) == 99`) and confirm it reports FAIL — proves each verifier can actually fail.
5. Run all three at the default `--n-attempts` for the shareable demo.

## Status

Slice 1 content is complete. It has **not** yet been validated end-to-end (requires Docker +
Snowflake connections). Expansion (SQL view creation, refactoring, code explanation, Python
data transform) is planned as an optional Slice 2.
