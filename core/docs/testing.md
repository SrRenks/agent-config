# Testing Strategy

## Unit Tests
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

## Integration Tests
- Test interactions between components (database, external services).
- Run against a test environment (e.g., testcontainers).
- Use a separate test database.

## End-to-End Tests
- Test full user workflows from entry to exit.
- Run only in CI, not during development.

## Test Conventions
- Test files: `*_test.go`, `*.spec.js`, `test_*.py`.
- Use table-driven tests where possible.
- Name tests: `TestFunctionName_Scenario_ExpectedOutcome`.

## CI Commands
- Run unit tests: `make test-unit`
- Run integration tests: `make test-integration`
- Run all tests: `make test`

## Quality Gates
- Tests must pass before merging.
- Code coverage must not decrease.
- Linter must pass with zero warnings.