Prepare a commit with:
1. `git diff --staged` or `git diff` if nothing staged - verify what's changing
2. Generate a conventional commit message (feat:, fix:, chore:, etc.)
3. Run pre-commit checks: linters, tests
4. Fresh-context review - a subagent with no session history reviews the staged diff for bugs, overreach, missing tests, unintended changes; fix valid findings
5. If all pass, stage files and commit
6. Report the commit hash
