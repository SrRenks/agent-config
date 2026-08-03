# Pre‑Completion Validation Checklist

Before you declare a task complete, run through this checklist and confirm each applicable item:

- [ ] Tests – all new and existing tests pass locally.
- [ ] Linters – no warnings or errors (run the project’s lint command).
- [ ] Complexity – all modified functions/modules stay within the budgets defined in `docs/complexity.md`; if exceptions exist, they are documented.
- [ ] Architecture – the change respects the architectural dependency rules (see `docs/architecture.md`).
- [ ] Dependencies – no new dependencies without approval; existing ones are up‑to‑date and secure.
- [ ] Documentation – updated relevant docs (e.g., API, README, ADR) if behavior changed.
- [ ] Public APIs – no breaking changes unless explicitly agreed; migration plan documented.
- [ ] Security – no new vulnerabilities (run security scans if available); secrets are not exposed.
- [ ] Performance – no obvious performance regressions; if performance is critical, run benchmarks.
- [ ] Duplication – no unnecessary code duplication introduced; if duplication is unavoidable, note why.
- [ ] Maintainability – the change does not decrease the overall maintainability (e.g., Maintainability Index) without justification.
- [ ] Diff review – you have reviewed your own diff for any unintended changes.

If any checkbox is not satisfied, do not finish the task – fix the issue first.
