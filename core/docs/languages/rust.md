# Rust Guidelines

## Tooling

Use:
- rustfmt
- clippy
- cargo test

## Recommended Linter Configuration

Use `clippy` with these lints:

- `clippy::too_many_lines` - function length (threshold: 60)
- `clippy::too_many_arguments` - parameters (threshold: 4)
- `clippy::result_unit_err` - keep error types meaningful

Clippy does not currently enforce all repository complexity budgets.

Use:
- clippy
- cargo fmt
- cargo test

Example `Cargo.toml`:

```toml
[lints.clippy]
cognitive_complexity = { level = "deny", threshold = 15 }
too_many_lines = { level = "deny", threshold = 60 }
```

Also enable cargo-audit in CI to check for vulnerable dependencies.

## Practices

Use ownership-driven design, explicit error types, and zero-cost abstractions.
Do not clone unnecessarily. Do not allocate excessively. Never use unsafe without justification.