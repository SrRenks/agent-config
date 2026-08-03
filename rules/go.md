---
paths:
  - "**/*.go"
---

# Go-Specific Rules

- Use `context.Context` as first parameter in all functions that do I/O.
- Never use `panic` for error handling. Return errors.
- Always check errors. Never use `_` to discard them without a comment explaining why.
- Prefer `errors.New` for simple errors, `fmt.Errorf` with `%w` for wrapping.
- Use `defer` for cleanup. Resource acquisition immediately followed by `defer release()`.
- Goroutines must have clear ownership and cancellation via context.
- Use `sync.WaitGroup` or `errgroup.Group` for goroutine coordination.
- No global mutable state.
