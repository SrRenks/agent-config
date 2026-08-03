# Testing strategy

## Unit tests
- Test individual functions and methods in isolation.
- Isolate external systems when appropriate.
- Use fakes or test containers when integration behavior matters.
- Use mocks only when they provide meaningful isolation.

Coverage is a measurement, not the goal.

Tests must verify:
- expected behavior
- edge cases
- error paths
- regression scenarios

Do not add tests only to increase coverage numbers.

## Integration tests
- Test interactions between components (database, external services).
- Run against a test environment (e.g., testcontainers).
- Use a separate test database.

## End-to-end tests
- Test full user workflows from entry to exit.
- Run only in CI, not during development.

## Test conventions
- Test files: `*_test.go`, `*.spec.js`, `test_*.py`.
- Use table‑driven tests where possible.
- Name tests: `TestFunctionName_Scenario_ExpectedOutcome`.

## CI commands
- Run unit tests: `make test-unit`
- Run integration tests: `make test-integration`
- Run all tests: `make test`

## Quality gates
- Tests must pass before merging.
- Code coverage must not decrease.
- Linter must pass with zero warnings.