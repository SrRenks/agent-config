# agent-config

Single source of truth for how coding agents behave across all tools and all
projects: Claude Code, Codex, Gemini CLI, Cursor, dsh (DeepSeek Harness), and
any other AGENTS.md-reading tool.

## Layout

```
AGENTS.md                universal rules - no tool-specific content
core/                    tool-free content
  docs/                  reference docs (read on demand)
  templates/             .ai/ file templates
  principles.md          universal agent principles
skills/                  one source of truth per procedure
  plan/ onboard/ context/ review/ ci/ ship/ extend-config/   (SKILL.md dirs)
agents/                  per-tool adapters
  claude-code/           CLAUDE.md, settings.json, hooks/, rules/, commands/
  gemini/                GEMINI.md
  dsh/                   install.sh + presets/renks/
ai-init, ai-context      per-project tooling
setup.sh                 installs every tool bridge
```

## How universality works

- **One procedure, one file.** `skills/*/SKILL.md` carries a combined frontmatter
  (`name`/`description`/`whenToUse`) that both dsh and Claude Code read - they
  share the dir+SKILL.md format. Claude slash commands
  (`agents/claude-code/commands/`) are symlinks into `skills/`.
- **Shared skills, two mounts.** `~/.claude/skills` and `~/.dsh/skills` both
  point at the same `skills/` directory.
- **Dual-format rules.** `agents/claude-code/rules/` carry combined frontmatter
  (`description` + `globs` + `paths`) so the same files serve Claude Code and
  Cursor.
- **Project-root AGENTS.md.** `ai-init` links `./AGENTS.md` in each project -
  the path every AGENTS.md-reading tool (Codex, Cursor, Windsurf, Amp, Jules,
  Claude Code) looks for.

## Supported tools

| Tool | Bridge | Install path |
|---|---|---|
| Claude Code | `agents/claude-code/` (CLAUDE.md, skills, hooks, rules, commands, settings.json, claudeignore) | `~/.claude/` |
| Codex | `AGENTS.md` | `~/.codex/AGENTS.md` |
| Gemini CLI | `agents/gemini/GEMINI.md` | `~/.gemini/GEMINI.md` |
| Cursor | shared rules (combined frontmatter) | `~/.cursor/rules` |
| dsh | `agents/dsh/` (preset + installer) | `~/.dsh/` |
| Generic AGENTS.md tools | `AGENTS.md` | `~/.agents/AGENTS.md` |

## Install

```bash
git clone git@github.com:SrRenks/agent-config.git ~/.config/agent-config
cd ~/.config/agent-config
./setup.sh                    # all tool bridges
bash agents/dsh/install.sh    # dsh preset + shared skills
```

`setup.sh` derives paths from its own location (clone-anywhere) and backs up
existing real files to `backups/` before replacing them with symlinks.

## Per-project setup

```bash
ai-init      # .ai/ skeleton + repo-root AGENTS.md symlink
ai-context   # context topic files + README on demand
```

## Design principles

- Shared config is READ-ONLY for agents; project rules live in `.ai/project.md`.
- `.ai/` is never committed (gitignored by `ai-init`).
- Symlinks propagate `git pull` updates to every tool and project instantly.
- Lean by evidence: instructions are pulled on demand, not dumped into every
  request (see `core/docs/evals.md`).

## Updating

```bash
cd ~/.config/agent-config && git pull
```

## License

MIT
