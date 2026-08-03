<!-- type: reference -->

# Validation Checklist

Run before declaring any task complete. Tick all that apply.

## Build and tests
- [ ] Build passes with zero errors.
- [ ] All tests pass.
- [ ] Lint — no new warnings introduced by the change.

## Code quality
- [ ] Complexity budgets met: cyclomatic ≤10, cognitive ≤15, params ≤4, nesting ≤3, lines/function ≤60, file ≤500.
- [ ] Every function handles errors, logs operations, covers edge cases.
- [ ] No dead code, debug artifacts, or speculative abstractions.
- [ ] No new dependencies without approval.

## Security and privacy
- [ ] No secrets/tokens logged or committed.
- [ ] Sensitive data stays local (no unexpected network calls).
- [ ] Permission usage documented and justified.

## Locale and UX
- [ ] User-facing strings in the correct language.
- [ ] Numbers, currency, and dates formatted correctly (no floats for money).

## Diff hygiene
- [ ] Diff touches only the requested scope; no drive-by refactoring.
- [ ] Only explicitly staged files (no `git add -A`).
- [ ] Committed only after human approval.

---

[← Back to docs index](index.md)
