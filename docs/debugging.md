# Debugging Guide

## Reproduce
- Get a minimal reproduction scenario.
- Capture logs, stack traces, and environment details.
- Use the same versions of dependencies.

## Isolate
- Narrow down to the smallest piece of code that fails.
- Use binary search: comment out half the code.
- Write a failing test to pin the behavior.

## Verify Assumptions
- Check that configuration is correct.
- Verify that dependencies are up to date.
- Ensure the bug is not caused by data corruption.

## Fix
- Apply the minimal fix that solves the issue.
- Add a regression test to prevent reoccurrence.
- Update documentation if behavior changes.

## Post‑Mortem
- Document the root cause.
- Share learnings with the team.
- Improve tests and monitoring.