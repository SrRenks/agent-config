---
paths:
  - "**/*_test.go"
  - "**/test_*.py"
  - "**/*.test.ts"
  - "**/*.spec.ts"
  - "**/*.test.js"
  - "**/*.spec.js"
  - "**/tests/**"
---

# Testing Rules

- One assertion per test when practical. Multiple related assertions OK if they test one behavior.
- Test names must describe the scenario and expected outcome: `TestFunctionName_Scenario_ExpectedOutcome`
- Tests must cover: happy path, error path, edge cases, regression scenarios.
- Use table-driven tests in Go. Use parametrize in Python.
- Mock external dependencies. Never call real APIs in unit tests.
- Tests must be independent — no shared mutable state between tests.
- If a test is flaky, fix the root cause. Do not skip or retry without investigation.
