# Agent-Config Repository Map

Layout of `~/.config/agent-config/` - the single source of truth for AI/agent configuration.
This config is READ-ONLY for agents. Projects do not copy it: `ai-init` creates the project's `.ai/` directory, whose `agents.md` imports this config.

## Root level
- `AGENTS.md` - universal agent rules (v2026-08-03). Symlinked as each project's `.ai/agents.md`; also linked to `~/.codex/AGENTS.md`, `~/.agents/AGENTS.md`.
- `CLAUDE.md` - imports `AGENTS.md` + Claude Code specifics. → `~/.claude/CLAUDE.md`.
- `GEMINI.md` - imports `AGENTS.md` + Gemini specifics. → `~/.gemini/GEMINI.md`.
- `CLAUDE.local.md` - personal preferences (not shared). → `~/.claude/CLAUDE.local.md`.
- `settings.json` - Claude permissions + hooks. → `~/.claude/settings.json`.
- `claudeignore` - never-access patterns. → `~/.claudeignore`.
- `ai-init` - creates the project's `.ai/` directory (agents.md symlink, project.md, memory files, docs/) and gitignores it. → `~/.local/bin/ai-init`.
- `setup.sh` - one-time global install (creates the `~/.claude`, `~/.codex`, `~/.gemini`, `~/.agents` links).

## Reference library - `docs/`
Shared across all projects; read on demand (AGENTS.md §3). Never copied into a project - a project's `docs/` holds project docs only.
- `architecture.md`, `coding-standards.md`, `testing.md`, `security.md`, `complexity.md`, `coupling.md`, `debugging.md`, `maintainability.md`, `performance.md`, `development-workflow.md`, `validation-checklist.md`, `dependency-policy.md`, `git-workflow.md`, `onboarding.md`
- `ai-directory.md` - the `.ai/` structure standard (files, names, creation rules)
- `project-docs.md` - the committed docs/ + README standard (templates, naming, workflow)
- `repository-map.md` - this file
- `decisions/` - ADR template
- `languages/` - go, kotlin, python, rust

## Agent support
- `skills/RULES.md` - universal agent principles (Karpathy/llm-rigor + operational rules)
- `rules/` - scoped rules (Claude Code, by path filter): go, python, rust, security, testing
- `commands/` - slash commands: `ci`, `review`, `ship`
- `hooks/` - lifecycle hooks: `session-init`, `lint-check`, `block-danger`

## Project templates - `templates/`
Seeded into `.ai/` by `ai-init` (per-project, gitignored):
- `project.md` - project rules starter (stack, build/test/lint, conventions); `.ai/agents.md` is a symlink to `AGENTS.md`, not a template
- `convention-doc.md` - template for agent-created convention docs (`.ai/docs/`): purpose, imperative rules, pointers
- `session.md` - current session state
- `assumptions.md` - decision/assumption log
- `scratchpad.md` - working notes
- `README.md` - root enterprise README (superficial overview; deep docs go in `docs/`)
- `project-docs/` - starters for the committed docs/: `repository-map.md`, `architecture.md`

## Notes
- This repository configures AI coding agents; it contains no application code.
- Projects keep agent configuration in their own `.ai/` directory - repos stay project-only, `.ai/` stays local and never committed.