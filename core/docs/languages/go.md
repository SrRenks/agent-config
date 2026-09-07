# Go Guidelines

## Tooling

Use:
- gofmt
- go vet
- golangci-lint

## Recommended Linter Configuration

When using `golangci-lint`, enable these analyzers to enforce the repository's policies:

- `gocyclo` - cyclomatic complexity (budget: 10)
- `gocognit` - cognitive complexity (budget: 15)
- `cyclop` - alternative cyclomatic complexity checker
- `funlen` - function length (budget: 60 lines)
- `nestif` - nesting depth (budget: 3)
- `maintidx` - maintainability index (target ≥ 70)
- `dupl` - code duplication detection
- `staticcheck`, `govet`, `errcheck`, `unused` - general correctness and hygiene

Configure `nestif` according to the project's desired threshold. Note that it scores nested `if` complexity rather than enforcing an exact maximum nesting depth.

## Practices

Use small packages, explicit error handling, context propagation, and the standard library when possible.

Never create unnecessary interfaces. Do not use excessive dependency injection. Do not use package-level mutable state.