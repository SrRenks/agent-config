# agent-config

Shared AI agent behavior configuration - a single source of truth for how
coding agents (Claude Code, Cursor, CodeCompanion, Gemini CLI, Codex, and
others) should behave across all your projects.

## What it does

- **One config, all tools.** The shared rules in `AGENTS.md` apply everywhere.
  Tool-specific wrappers (`CLAUDE.md`, `GEMINI.md`) add tool-specific notes
  and then include the shared config.
- **Per-project overrides.** Each project gets a `.ai/` directory with a
  symlink to the shared config plus project-specific files (`project.md`
  for stack/build/test/conventions, `context/` for domain knowledge).
- **Predictable agent behavior.** Non-negotiable rules: no flattery, explain
  changes, disagree with evidence, never fabricate, surgical edits only,
  test-first, complexity budgets, no new dependencies without approval.

## Supported tools

| Tool | File | Install path |
|------|------|-------------|
| Claude Code | `CLAUDE.md`, `CLAUDE.local.md`, `settings.json`, `skills/`, `hooks/`, `rules/`, `commands/`, `claudeignore` | `~/.claude/` |
| Cursor / Codex | `AGENTS.md` | `~/.codex/AGENTS.md` |
| CodeCompanion (Neovim) | `AGENTS.md` | via `.ai/agents.md` symlink in each project |
| Gemini CLI | `GEMINI.md` | `~/.gemini/GEMINI.md` |
| Generic fallback | `AGENTS.md` | `~/.agents/AGENTS.md` |

## Install

```bash
git clone https://github.com/your-username/agent-config.git ~/.config/agent-config
cd ~/.config/agent-config
./setup.sh
```

`setup.sh` creates symlinks from `~/.config/agent-config/` to each tool's
expected path. Existing real files are backed up to `backups/` before being
replaced.

## Per-project setup

In any project directory:

```bash
ai-init      # creates .ai/ with symlink + skeleton files
ai-context   # detects stack, db, deps, conventions; generates context + README
```

- `ai-init` - sets up `.ai/agents.md` (symlink to shared config), skeleton
  memory files (`project.md`, `session.md`, `assumptions.md`, `scratchpad.md`),
  and a `.gitignore` entry. Detects project maturity (NEW vs EXISTING).
- `ai-context` - detects language, framework, database, external services, and
  local conventions; generates `.ai/context/` topic files and `README.md`.
  Only generates files that apply (no database.md without a database).

## Repository structure

```
~/.config/agent-config/
├── AGENTS.md              # shared agent rules (source of truth)
├── CLAUDE.md              # Claude Code wrapper (includes AGENTS.md)
├── CLAUDE.local.md        # personal overrides (not committed in practice)
├── GEMINI.md              # Gemini CLI wrapper (includes AGENTS.md)
├── settings.json          # Claude Code permissions + hooks config
├── claudeignore           # files Claude Code should never access
├── setup.sh               # one-time install: creates symlinks
├── ai-init                # per-project .ai/ initialization script
├── ai-context             # on-demand context + README generator
├── commands/              # Claude Code slash commands
│   ├── ci.md              # /ci - run full CI pipeline locally
│   ├── review.md          # /review - review pending changes
│   └── ship.md            # /ship - prepare and commit
├── hooks/                 # Claude Code hooks (PreToolUse, PostToolUse, SessionStart)
│   ├── block-danger       # blocks rm -rf, sudo, git push --force, etc.
│   ├── lint-check         # auto-lints files after edits
│   └── session-init       # ensures .ai/ is set up on session start
├── rules/                 # scoped rules by language/concern
│   ├── go.md
│   ├── python.md
│   ├── rust.md
│   └── security.md
├── skills/                # agent skills (loaded as context)
│   └── RULES.md           # universal agent principles (Karpathy, complexity budgets)
├── docs/                  # reference docs (read on demand by agents)
│   ├── ai-directory.md    # .ai/ directory standard
│   ├── architecture.md
│   ├── coding-standards.md
│   ├── complexity.md
│   ├── coupling.md
│   ├── debugging.md
│   ├── decisions/         # ADR template
│   ├── dependency-policy.md
│   ├── development-workflow.md
│   ├── git-workflow.md
│   ├── languages/         # go, kotlin, python, rust
│   ├── maintainability.md
│   ├── performance.md
│   ├── project-docs.md
│   ├── repository-map.md
│   ├── security.md
│   ├── testing.md
│   └── validation-checklist.md
└── templates/             # templates for new projects
    ├── project.md
    ├── session.md
    ├── assumptions.md
    ├── scratchpad.md
    ├── README.md
    ├── convention-doc.md
    ├── CHANGELOG.md
    └── project-docs/      # architecture, getting-started, index, repository-map, roadmap, validation-checklist
```

## Design principles

- **Shared config is read-only.** Agents never edit `~/.config/agent-config/`.
  Project-specific rules go in `.ai/project.md` and `.ai/docs/`.
- **No templates copied into projects.** `ai-context` generates context files
  and README.md dynamically based on what it detects - no generic filler.
- **`.ai/` is never committed.** Per-project agent knowledge stays local.
- **Symlinks propagate updates.** When the shared config is updated (git pull),
  all projects pick up the changes immediately through the `.ai/agents.md`
  symlink.

## Updating

```bash
cd ~/.config/agent-config
git pull
```

All projects get the updated shared rules immediately via the symlink. No
per-project action needed.

## License

MIT
