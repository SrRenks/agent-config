---
name: review
description: Review all pending changes on the current branch: diff, unpushed commits, linters, tests, a fresh-context adversarial pass, and a structured report.
whenToUse: When the user asks to review pending changes or before declaring work done.
---
Review all pending changes on the current branch:
1. git diff - show the full diff
2. git log @{u}..HEAD - commits not yet pushed
3. Run linters on all changed files
4. Run tests for all changed packages/modules
5. Fresh-context review: delegate the diff (or a structured summary of it) to a subagent that does not share this conversation. Instruct it to hunt for bugs, overreach beyond the request, missing tests, and unintended changes - not to praise the work. Fix anything it finds that is valid.
6. Report: summary of changes, any lint warnings, test results, fresh-review findings, files touched
