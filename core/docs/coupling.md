# Coupling Constraints

- Minimise dependencies between packages/modules.
- Do not create bidirectional dependencies.
- Expose small, stable interfaces.
- Do not introduce dependency inversion (interfaces) unless you have at least two concrete implementations.
- Keep dependency graphs acyclic; use tools like `go mod graph` or `cargo tree` to check.