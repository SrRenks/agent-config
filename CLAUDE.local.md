# Personal preferences - not committed, not shared.
# Loaded after CLAUDE.md. Override project conventions here.

# Editor
- I use Neovim. Set EDITOR=nvim for commit messages and multi-line input.
- Prefer 2-space indent in JS/TS. 4-space in Go. PEP 8 for Python.

# Git
- Branch naming: `feature/description`, `fix/description`, `chore/description`
- Commit messages: conventional commits (feat:, fix:, chore:, docs:, refactor:, test:)

# Testing
- Always run tests with `--verbose` flag.
- If a test is flaky, fix the flakiness - don't skip it.

# Communication
- Prefer terminal commands over GUI suggestions.
- When proposing a change, show the exact diff or command first, then explain.
