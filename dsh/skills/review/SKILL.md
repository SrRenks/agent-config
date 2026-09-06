---
name: review
description: Review all pending changes on the current branch: diff, unpushed commits, linters, tests, and a structured report.
whenToUse: When the user asks to review pending changes or before declaring work done.
---
Review all pending changes on the current branch:
1. git diff — show the full diff
2. git log @{u}..HEAD — commits not yet pushed
3. Run linters on all changed files
4. Run tests for all changed packages/modules
5. Report: summary of changes, any lint warnings, test results, files touched
