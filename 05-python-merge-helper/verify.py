#!/usr/bin/env python3
"""Check for Exercise 05. No Snowflake needed — standard library only.

Usage:
    python verify.py [path/to/merge_helper.py]   # defaults to merge_helper.py

Loads build_merge(), calls it with a sample, and checks the generated MERGE
statement contains the required parts. Prints PASS or FAIL.
"""

import importlib.util
import pathlib
import sys


def fail(msg: str) -> None:
    print(f"FAIL: {msg}")
    sys.exit(1)


def load_build_merge(path: pathlib.Path):
    if not path.exists():
        fail(f"{path} not found")
    spec = importlib.util.spec_from_file_location("merge_helper", path)
    module = importlib.util.module_from_spec(spec)
    try:
        spec.loader.exec_module(module)
    except Exception as e:  # noqa: BLE001
        fail(f"could not import {path}: {e}")
    if not hasattr(module, "build_merge"):
        fail("module has no function named build_merge")
    return module.build_merge


def main() -> None:
    path = pathlib.Path(sys.argv[1] if len(sys.argv) > 1 else "merge_helper.py")
    build_merge = load_build_merge(path)

    try:
        result = build_merge("TARGET_T", "SOURCE_S", ["id"], ["name", "amount"])
    except Exception as e:  # noqa: BLE001
        fail(f"build_merge raised an error: {e}")

    if not isinstance(result, str):
        fail(f"build_merge must return a string, got {type(result).__name__}")

    norm = " ".join(result.lower().split())
    required = [
        "merge into target_t",
        "using source_s",
        "t.id = s.id",
        "when matched then update set",
        "t.name = s.name",
        "t.amount = s.amount",
        "when not matched then insert",
    ]
    missing = [r for r in required if r not in norm]
    if missing:
        fail("generated MERGE is missing: " + "; ".join(missing) + f"\n--- got ---\n{result}")

    print("PASS: build_merge produces a valid Snowflake MERGE statement")
    sys.exit(0)


if __name__ == "__main__":
    main()
