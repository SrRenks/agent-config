# Go guidelines

## Tooling

Use:
- gofmt
- go vet
- golangci-lint

## Recommended linter configuration

When using `golangci-lint`, turn on these analyzers to enforce the repository's policies:

- `gocyclo` - cyclomatic complexity (budget: 10)
- `gocognit` - cognitive complexity (budget: 15)
- `cyclop` - alternative cyclomatic complexity checker
- `funlen` - function length (budget: 60 lines)
- `nestif` - nesting depth (budget: 3)
- `maintidx` - maintainability index (target ≥ 70)
- `dupl` - code duplication detection
- `staticcheck`, `govet`, `errcheck`, `unused` - general correctness and hygiene

`nestif` scores nested `if` complexity rather than enforcing an exact nesting depth, so it complements the depth budget above instead of replacing it.

## Practices

Use small packages, explicit error handling, context propagation, and the standard library when possible.

Never create unnecessary interfaces. Do not use excessive dependency injection. Do not use package-level mutable state.