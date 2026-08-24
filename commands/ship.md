Prepare a commit with:
1. `git diff --staged` or `git diff` if nothing staged - verify what's changing
2. Generate a conventional commit message (feat:, fix:, chore:, etc.)
3. Run pre-commit checks: linters, tests
4. If all pass, stage files and commit
5. Report the commit hash
