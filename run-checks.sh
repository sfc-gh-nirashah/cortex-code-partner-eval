#!/usr/bin/env bash
# Convenience runner for the CODE exercises (05, 06, 07).
# SQL exercises (01-04, 08) are verified in Snowsight with their own verify.sql.
#
# Convention: save each exercise's solution inside its own folder, i.e.
#   05-python-merge-helper/merge_helper.py
#   06-streamlit-app/app.py
# Exercise 07's verify.py runs the suite in its starter/ folder automatically.

set -u
PY="$(command -v python3 || command -v python)"
echo "Using interpreter: ${PY:-<none found>}"
[ -z "${PY:-}" ] && { echo "Python 3 not found. Install it, or run each verify.py manually."; exit 1; }

echo ""
echo "=== 05 python-merge-helper ==="
if [ -f 05-python-merge-helper/merge_helper.py ]; then
  "$PY" 05-python-merge-helper/verify.py 05-python-merge-helper/merge_helper.py || true
else
  echo "skipped — create 05-python-merge-helper/merge_helper.py first"
fi

echo ""
echo "=== 06 streamlit-app ==="
if [ -f 06-streamlit-app/app.py ]; then
  "$PY" 06-streamlit-app/verify.py 06-streamlit-app/app.py || true
else
  echo "skipped — create 06-streamlit-app/app.py first"
fi

echo ""
echo "=== 07 make-tests-pass ==="
"$PY" 07-make-tests-pass/verify.py || true
