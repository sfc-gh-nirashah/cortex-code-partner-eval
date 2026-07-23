#!/bin/bash

# Standard pytest runner for Cortex Code partner evals.
# Copied from evals/simple_tests/_shared/tests/test.sh — same contract:
#   runs pytest on /tests/, writes 1/0 to /logs/verifier/reward.txt.

pytest --ctrf /logs/verifier/ctrf.json /tests/ -rA

if [ $? -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
