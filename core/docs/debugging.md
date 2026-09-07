# Debugging guide

## Reproduce
- Get a minimal reproduction scenario.
- Capture logs, stack traces, environment details, and the exact dependency versions.

## Isolate
- Narrow down to the smallest piece of code that fails; commenting out half at a time is the fastest search.
- Write a failing test to pin the behavior.

## Verify assumptions
- Check that configuration is correct, dependencies are current, and the data is not corrupt.

## Fix
- Apply the minimal fix that solves the issue.
- Add a regression test to prevent reoccurrence.
- Update documentation if behavior changes.

## Post-mortem
- Document the root cause.
- Share learnings with the team.
- Improve tests and monitoring.