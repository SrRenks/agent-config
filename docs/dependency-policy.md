# Dependency Policy

## Adding a New Dependency
- Must be justified (what problem does it solve?).
- Must be approved by the team lead.
- Must be actively maintained (recent commits).
- Must have acceptable license (MIT, Apache 2.0, BSD).
- Must not have known critical vulnerabilities.

## Managing Dependencies
- Pin to exact versions or use lock files.
- Regularly update dependencies (weekly/monthly).
- Run `cargo‑deny`, `npm audit`, `govulncheck` in CI.

## Unused Dependencies
- Remove unused dependencies to reduce attack surface.
- Run `go mod tidy`, `npm prune`, `poetry remove` regularly.

## Transitive Dependencies
- Monitor transitive dependencies for vulnerabilities.
- Use tools that scan the entire tree.

## Evaluation Process

Before adding a dependency:
1. Verify the problem cannot be solved with existing code or standard libraries.
2. Evaluate maintenance activity.
3. Check security history.
4. Consider binary size and runtime impact.
5. Document the reason for adoption.