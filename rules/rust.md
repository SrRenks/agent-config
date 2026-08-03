---
paths:
  - "**/*.rs"
---

# Rust-Specific Rules

- Use `Result<T, E>` and `Option<T>`. Never `unwrap()` or `expect()` in production code unless the invariant is logically impossible.
- Use `?` operator for error propagation. Add context with `.context()` (anyhow) or `.map_err()`.
- Derive traits explicitly: `#[derive(Debug, Clone, PartialEq)]`.
- Use `&str` for borrowed string params, `String` for owned.
- No unsafe blocks without a safety comment explaining why it's sound.
- Use `cargo clippy` with `-- -D warnings`.
- Follow Rust API guidelines for naming and conventions.
