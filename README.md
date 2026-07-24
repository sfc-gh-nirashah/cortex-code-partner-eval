# Cortex Code — Partner Exercises

A set of self-contained exercises for evaluating **Snowflake Cortex Code** across the
**software/data development lifecycle (SDLC)** — building, fixing, refactoring, composing
pipelines, writing code, debugging, and shipping an app. Each exercise is a business
scenario, a prompt you give to Cortex Code, and a self-contained way to verify the result.

These are **development-phase** tasks (what a Snowflake app/data developer does), not
"answer-a-business-question" data queries. Every exercise is verified the way ADE-bench
verifies work — **run the artifact and compare it to an expected result** — but with **no
framework**: just a `verify.sql` or `verify.py`.

**You only need:** Cortex Code (always); a Snowflake worksheet (SQL exercises); Python 3
(code exercises). No Harbor, no Docker.

---

## Choose a path

Pick based on how much time you have and how deep you want to go — simple combo to full showcase.

| Path | Best for | Exercises | Approx. time |
|------|----------|-----------|--------------|
| **Quick taste** (closest to "a couple of prompts") | A first look | 1, 2 | ~20 min |
| **Developer combo** | See the everyday range | 1 – 6 | ~1.5 hrs |
| **Full agent showcase** | See real SDLC power | 1 – 8 | ~2.5 hrs |

**Short on time but want the "aha"?** Do **Exercise 7** on its own (~30 min) — it's the one
that best shows Cortex Code working like a developer, not autocomplete.

---

## All exercises

Ordered simple → complex.

| # | Exercise | What it proves | Complexity | Time | Verify |
|---|----------|----------------|-----------|------|--------|
| 1 | [Build a data model](01-build-a-model/) | Generate a reusable artifact from a business need | Easy | ~10 min | `verify.sql` |
| 2 | [Fix a broken transformation](02-fix-a-transformation/) | Read errors, repair a failing model | Easy | ~10 min | `verify.sql` |
| 3 | [Refactor a model](03-refactor-a-model/) | Improve code without regressions | Medium | ~15 min | `verify.sql` |
| 4 | [Build a 2-layer pipeline](04-build-a-pipeline/) | Compose dependent models (staging → mart) | Medium | ~20 min | `verify.sql` |
| 5 | [Python utility + tests](05-python-merge-helper/) | Generate verifiable code | Medium | ~15 min | `python verify.py` |
| 6 | [Streamlit app](06-streamlit-app/) | Build an interactive app | Medium | ~20 min | `python verify.py` |
| 7 | [Make the test suite pass](07-make-tests-pass/) 🚩 | The real agent loop: multi-file changes, run tests, iterate | Hard | ~30 min | `python verify.py` |
| 8 | [Diagnose by running it](08-diagnose-by-running/) | Investigate live data to find a bug (tool use) | Hard | ~25 min | `verify.sql` |

---

## How to use

1. **Once:** run [`setup.sql`](setup.sql) in a Snowsight worksheet — it creates
   `CORTEX_PARTNER_DEMO.SALES` with a small seeded dataset (used by the SQL exercises).
   *(Exercise 8 also needs its own `setup_08.sql`.)*
2. Open an exercise folder's `README.md`.
3. Paste its **Prompt** into Cortex Code and let it work.
4. **Verify:**
   - SQL exercises (1–4, 8): run the folder's `verify.sql` in your worksheet → `PASS`/`FAIL`.
   - Code exercises (5, 6, 7): run `python verify.py [file]` → `PASS`/`FAIL`.

That's the whole loop: **scenario → prompt → run the artifact → verify.**

## Cleanup

```sql
DROP DATABASE IF EXISTS CORTEX_PARTNER_DEMO;
```
