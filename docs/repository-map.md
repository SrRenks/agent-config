# Agent-Config Repository Map

Layout of `~/.config/agent-config/` - the single source of truth for AI/agent configuration.
This config is READ-ONLY for agents. Projects do not copy it: `ai-init` creates the project's `.ai/` directory, whose `agents.md` imports this config.

## Root level
- `AGENTS.md` - universal agent rules (v2026-09-06). Symlinked as each project's `.ai/agents.md`; also linked to `~/.codex/AGENTS.md`, `~/.agents/AGENTS.md`, and `~/.dsh/AGENTS.md`.
- `CLAUDE.md` - imports `AGENTS.md` + Claude Code specifics (model tiering policy). → `~/.claude/CLAUDE.md`.
- `GEMINI.md` - imports `AGENTS.md` + Gemini specifics. → `~/.gemini/GEMINI.md`.
- `CLAUDE.local.md` - personal preferences (not shared). → `~/.claude/CLAUDE.local.md`.
- `settings.json` - Claude permissions + hooks (PreToolUse block-danger, PostToolUse lint-check; session-init is OPT-IN and not wired). → `~/.claude/settings.json`.
- `claudeignore` - never-access patterns. → `~/.claudeignore`.
- `ai-init` - creates the project's `.ai/` directory (agents.md symlink, project.md, memory files, docs/) and gitignores it. → `~/.local/bin/ai-init`.
- `setup.sh` - one-time global install (creates the `~/.claude`, `~/.codex`, `~/.gemini`, `~/.agents` links).

## DSH integration - `dsh/`
- `dsh/presets/renks/` - the DEFAULT preset (mirrors the live roster `~/.dsh/.agent-presets/renks/`). Evidence-based instruction delivery: no full AGENTS.md digest and no skill-catalog injection; `instruction-hint.mjs` injects one "read the instruction files" hint after the first tool call, and `skill-search.mjs` exposes `skill_search`/`skill_load`. Scale policy: search/load stays the default as the catalog grows; do not re-add catalog injection beyond ~3-5 skills.
- `dsh/skills/` - DSH skills (plan, onboard, context, review, ci, ship), symlinked to `~/.dsh/skills` for discovery by dsh-skill-filesystem.
- The experimental `liangshen` preset (minimal-bootstrap anchoring) lives in `~/.dsh/.agent-presets/liangshen/` and is not tracked here.

## Reference library - `docs/`
Shared across all projects; read on demand (AGENTS.md §3). Never copied into a project - a project's `docs/` holds project docs only.
- `architecture.md`, `coding-standards.md`, `testing.md`, `security.md`, `complexity.md`, `coupling.md`, `debugging.md`, `maintainability.md`, `performance.md`, `development-workflow.md`, `validation-checklist.md`, `dependency-policy.md`, `git-workflow.md`, `onboarding.md`
- `evals.md` - retained eval set (anchor checks + task set) to run before changing the default preset or shared rules
- `ai-directory.md` - the `.ai/` structure standard (files, names, creation rules)
- `project-docs.md` - the committed docs/ + README standard (templates, naming, workflow)
- `repository-map.md` - this file
- `decisions/` - ADR template
- `languages/` - go, kotlin, python, rust

## Agent support
- `skills/RULES.md` - universal agent principles (Karpathy/llm-rigor + operational rules); complexity budgets single-sourced in `docs/complexity.md`
- `rules/` - scoped rules (Claude Code, by path filter): go, python, rust, security, testing
- `commands/` - slash commands: `ci`, `review` (incl. fresh-context review), `ship` (incl. fresh-context review)
- `hooks/` - lifecycle hooks: `session-init` (opt-in), `lint-check`, `block-danger`

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