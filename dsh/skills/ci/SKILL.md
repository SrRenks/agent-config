---
name: ci
description: Run the full CI pipeline locally: lint, test, build, security scan, and report pass/fail per step.
whenToUse: When the user asks to run CI locally or verify the build before pushing.
---
Run the full CI pipeline locally:
1. make lint (or equivalent)
2. make test
3. make build
4. Security scan (if available)
5. Report: pass/fail for each step
