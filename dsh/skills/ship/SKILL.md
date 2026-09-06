---
name: ship
description: Prepare a commit: verify the staged diff, generate a conventional commit message, run pre-commit checks, commit, and report the hash.
whenToUse: When the user asks to commit or ship changes.
---
Prepare a commit:
1. git diff --staged (or git diff if nothing staged) — verify what is changing
2. Generate a conventional commit message (feat:, fix:, chore:, etc.)
3. Run pre-commit checks: linters, tests
4. If all pass, stage explicit files (never git add -A) and commit
5. Report the commit hash
