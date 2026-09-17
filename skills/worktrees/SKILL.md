---
name: worktrees
description: 'Do work in a git worktree so the main checkout stays untouched: create the worktree, work and verify inside it, land the branch, then clean up. Use when work must run alongside something else in the same repository, when the main checkout holds uncommitted changes, or when the user asks for an isolated workspace.'
---
Keep the main checkout stable and do the work somewhere else.

1. Check state first - `git status` and `git branch --show-current`. Never touch uncommitted changes that are not yours.
2. Create the worktree - `git worktree add <path> -b <branch>` from the repository root, with the path outside the main checkout.
3. Work and verify inside the worktree - tests, linters, and builds run there, on that branch.
4. One worktree, one task - do not reuse a worktree across unrelated tasks, and do not switch its branch mid-task.
5. Land it - push the branch and open the PR, or merge locally when the human says so. Ask before merging or rebasing.
6. Clean up - `git worktree remove <path>` once the branch is merged or abandoned, and delete the branch if it was abandoned.

Deliverable: the branch with the change, verified in isolation, plus the worktree path used.

Stop condition: report the branch, the worktree path, and the verification result. Ask before merging.
