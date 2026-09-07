# Coding Standards

## General Principles

- Follow the established conventions of the language ecosystem.
- Do not create abstractions without justification.
- When multiple implementations are correct, choose the one that:
    - minimizes complexity
    - minimizes dependencies
    - follows existing project patterns
    - minimizes API surface
    - minimizes future maintenance cost


## Naming

Follow language conventions:

### Go
- Exported identifiers: PascalCase.
- Unexported identifiers: camelCase.
- Initialisms remain uppercase:
  - HTTPServer
  - UserID
  - JSONParser

### Python
- Modules/packages: snake_case.
- Functions/variables: snake_case.
- Classes: PascalCase.
- Constants: UPPER_SNAKE_CASE.

### Rust
- Types/traits/enums: PascalCase.
- Functions/modules/variables: snake_case.
- Constants/statics: SCREAMING_SNAKE_CASE.

## Formatting

Always use ecosystem formatters:

- Go: gofmt
- Python: ruff format / black
- Rust: rustfmt

Do not manually format code when an automatic formatter exists.

## Error Handling

- Never ignore errors.
- Handle failures at the appropriate layer.
- Add context when propagating errors.
- Do not expose internal implementation details.

## Control Flow

To reduce nesting and improve readability:

- Use guard clauses - handle invalid or edge conditions early and return/exit immediately.
- Use early returns - Never use `else` blocks after a `return`, `break`, or `continue`.
- Flatten conditionals - use positive conditions where possible, and do not deep nesting.
- Do not use unnecessary `else` - if a previous branch returns, the `else` is redundant.

Example (good):

```
func process(data *Data) error {
    if data == nil {
        return errors.New("data is nil")
    }
    if !data.Valid() {
        return errors.New("invalid data")
    }
    // main logic
    return nil
}
```

Example (bad - deep nesting):
```
func process(data *Data) error {
    if data != nil {
        if data.Valid() {
            // main logic
            return nil
        } else {
            return errors.New("invalid data")
        }
    } else {
        return errors.New("data is nil")
    }
}
```

## Comments

Stance: the code must explain itself. A comment is a debt, not documentation.
Every comment must justify its existence with information the code cannot
carry. Inline comments are exceptional; docstrings are the normal path.

Docstrings (Go doc comments, Rust `///`, Python docstrings, Javadoc) document
every public module, class, function, and method. Content: contract, inputs
and outputs, errors and panics, side effects. Never restate the signature.

Inline comments are allowed only for exceptional information:
- the why of a decision that looks wrong without context (a workaround, a
  rejected alternative, an external constraint)
- invariants the code maintains but cannot express
- warnings: dangerous conditions, performance traps, thread-safety notes
- magic numbers whose justification is not in the name

Never write:
- what comments: anything that restates the code ("increment i", "now we loop")
- decorative banners, separator lines, section boxes
- per-line narration or journaling ("updating the value")
- commented-out code (delete it; git history keeps it)
- comments on obvious library calls or language keywords
- TODO comments without an actionable owner, or beyond the current task

Keep-test: delete the comment; if a future reader loses nothing, delete it
permanently. If a comment was needed to explain confusing code, refactor the
code instead of keeping the comment.

Comment prose follows the AI-writing tells (core/docs/ai-writing.md): plain
words, no promotional vocabulary, no em dashes.

Evidence and counterpoint: core/docs/sources.md (Martin, Atwood, Henney,
Ousterhout, Google style guides).

- Go: standard Go doc comments (`go.dev/doc/comment`) - begin with the
  identifier name, sentence-style.
- Rust: rustdoc `///` with the standard sections (`# Panics`, `# Errors`,
  `# Examples`, `# Safety`).

## Logging

Use structured logging when available.

Never log:
- passwords
- tokens
- secrets
- private data

Include useful context:
- operation name
- request identifiers
- relevant entity identifiers

## Concurrency

Follow language-specific best practices:

- Go: enforce clear goroutine ownership and explicit context cancellation.
- Python: choose threads, asyncio, or multiprocessing based on workload.
- Rust: respect ownership rules. Do not add unnecessary synchronization.

## Compatibility

Before changing:
- public APIs
- CLI interfaces
- configuration formats
- database schemas
- external contracts

Check existing usage and document migration requirements.

## Observability

For new features, include logs, metrics, tracing, and error context.

## Anti-Patterns

- Never create abstractions before duplication exists.
- Do not add interfaces solely for mocking.
- Never introduce a design pattern without a concrete problem.
- Never rewrite working code during feature changes.
- Do not add dependencies if the standard library solves the problem.
- Complex code is agent drag - expensive for both humans and AI agents. Code
  that is ergonomic for AI is also better for humans.

## Refactoring Rules

Before refactoring:
- confirm the existing behavior
- ensure tests cover affected behavior
- make incremental changes.

Do not refactor code only because it is stylistically different.