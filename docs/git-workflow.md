# Git Workflow (Shared Conventions)

Generic, production-grade Git conventions for every project.
Project-specific deviations go in the project's `.ai/docs/git-workflow.md` (local-only) and override this file.

## Branch model
- `main` — always green, protected. No direct pushes; every change lands via a pull request.
- Short-lived branches off `main`, named `<type>/<slug>`: `feat/...`, `fix/...`, `chore/...`, `docs/...`, `test/...`, `refactor/...`, `ci/...`.
- Delete branches after merge. Never reuse a merged branch.

## Commits — conventional and atomic
- Format: `<type>(<scope>): <subject>` — types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `perf`, `build`, `ci`, `revert`.
- Subject: imperative mood, lowercase, ≤ 72 chars, no trailing period.
- Body explains the *why* (and references decisions/issue IDs when relevant).
- Atomic: one logical change per commit; each commit compiles, passes tests, and is independently reviewable.
- Never `git add -A` / `git add .` — stage explicit files only.

## Pull requests & merge
- Open the PR early; PR title = the squash-commit subject.
- CI must pass before merge: build + lint + tests.
- Squash-merge to `main` — keeps main linear and `git bisect`-friendly.
- Delete the branch after merge.

## CI
- Every push to `main` and every PR targeting `main` runs the pipeline (build, lint, test) as the merge gate.

## Releases
- Tag `main` with semantic versions: `v0.1.0`, `v0.2.0`, …
- Changelog derived from conventional commit subjects (tooling when the first release is cut).

## History hygiene
- Never rewrite history after it has been pushed/shared.
- No scratch notes, tool artifacts, or generated files in commits.
