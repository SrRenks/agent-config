---
name: ship
description: Prepare a commit: verify the staged diff, generate a conventional commit message, run pre-commit checks (including a fresh-context review), commit, and report the hash.
whenToUse: When the user asks to commit or ship changes.
---
Prepare a commit:
1. git diff --staged (or git diff if nothing staged) - verify what is changing
2. Generate a conventional commit message (feat:, fix:, chore:, etc.) - plain wording, no AI-tell vocabulary (see core/docs/ai-writing.md)
3. Run pre-commit checks: linters, tests
4. Fresh-context review: have a subagent with no session history review the staged diff for bugs, overreach, missing tests, unintended changes, and comment noise; fix valid findings
5. If all pass, stage explicit files (never git add -A) and commit
6. Report the commit hash
