# agent-config

One set of instructions, skills, and reference docs for coding agents, shared by
Claude Code, Codex, Gemini CLI, Cursor, and dsh (DeepSeek Harness).

Every tool keeps its own config directory, and that is where agent setups drift
apart: the same rule gets written three times, updated twice, and contradicted
once. This repo holds the canonical copy and hands it to each tool through
symlinks, so `git pull` updates every tool and every project. The dsh preset is
the one exception, because its installer copies files into `~/.dsh/`.

The config is read-only for agents. Anything project-specific belongs in that
project's `.ai/` directory; shared rules stay project-agnostic.

## Supported tools

| Tool | Source in this repo | Bridge installed by `setup.sh` |
|---|---|---|
| Claude Code | `agents/claude-code/` (CLAUDE.md, settings.json, hooks, rules, commands, claudeignore) plus `skills/` | `~/.claude/` |
| Codex | `AGENTS.md` | `~/.codex/AGENTS.md` |
| Gemini CLI | `agents/gemini/GEMINI.md` | `~/.gemini/GEMINI.md` |
| Cursor | `agents/claude-code/rules/` (combined frontmatter) | `~/.cursor/rules` |
| Any AGENTS.md tool | `AGENTS.md` | `~/.agents/AGENTS.md` |
| dsh | `agents/dsh/` preset plus `skills/` | not by `setup.sh`: run `agents/dsh/install.sh`, which writes `~/.dsh/` |

## Requirements

- `bash` and `git`.
- `node` only for the preset YAML check inside `agents/dsh/install.sh`.
- dsh itself, if you want the dsh preset; the rest of the config works without it.

## Install

```bash
git clone git@github.com:SrRenks/agent-config.git ~/.config/agent-config
cd ~/.config/agent-config
./setup.sh                    # tool bridges and the git identity include
bash agents/dsh/install.sh    # dsh preset and shared skills (optional)
```

`setup.sh` derives every path from its own location, so the repo can be cloned
anywhere, and it is safe to re-run. A real file sitting where a symlink will go
is copied to `backups/<timestamp>/` first, so nothing is lost.

## Per-project setup

Run these from inside a project directory:

```bash
ai-init      # creates .ai/ and links .ai/agents.md to this config
ai-context   # writes .ai/context/ topic files and the project README on demand
```

`.ai/` holds what is specific to that project, and `ai-init` gitignores it:

| File | Contents |
|---|---|
| `.ai/agents.md` | symlink to this repo's `AGENTS.md`, do not edit |
| `.ai/project.md` | stack, build/test/lint commands, local conventions |
| `.ai/session.md` | current session state |
| `.ai/assumptions.md` | decision log |
| `.ai/scratchpad.md` | working notes |
| `.ai/context/` | domain, architecture, database, dependencies, conventions |
| `.ai/docs/` | project-specific convention docs |

`ai-context` writes only the files that apply: a project with no database gets no
`database.md` and no storage row in the README. Files it created before are left
alone unless you pass `--force`, which refreshes `index.md` and `README.md`.

## Repository layout

```
AGENTS.md              universal rules, no tool-specific content
setup.sh               installs every tool bridge on this machine
ai-init, ai-context    per-project tooling (linked into ~/.local/bin)
core/
  docs/                reference library, read on demand
  principles.md        universal agent principles
  templates/           .ai/ and project-docs skeletons
agents/
  claude-code/         CLAUDE.md, settings.json, hooks/, rules/, commands/
  gemini/              GEMINI.md
  dsh/                 install.sh and presets/renks/
skills/                one procedure per directory, each a SKILL.md
README.md, LICENSE     this file and the license
```

`core/docs/repository-map.md` is the structure doc: every root file, the tool
adapters, the reference library, and the templates.

## How one config reaches every tool

- `skills/` is symlinked to both `~/.claude/skills` and `~/.dsh/skills`. Every
  skill carries combined frontmatter (`name`, `description`, `whenToUse`); dsh
  uses `whenToUse` for its skill search, and both tools read the same directory
  plus SKILL.md layout. The Claude slash commands in
  `agents/claude-code/commands/` are symlinks into this directory.
- Files in `agents/claude-code/rules/` carry `description` with `globs` for
  Cursor and `paths` for Claude Code, so one file serves both.
- `ai-init` links `./AGENTS.md` into each project, which is the path Codex,
  Cursor, Windsurf, Amp, Jules, and Claude Code look for.
- Editing a rule and pulling updates every tool and every project, because the
  bridges are symlinks. Only the dsh preset needs its installer re-run.

## What agents are told

`AGENTS.md` is the contract every tool receives: 98 lines covering scope and
ownership, non-negotiables, project entry, the CRISPY workflow, memory files, the
no-go list, and tool usage. Read it directly for the rules; depth lives in
`core/docs/`, which agents load on demand.

## Skills

| Skill | What it does |
|---|---|
| `plan` | surveys the repo and writes a numbered implementation plan with success criteria |
| `onboard` | reads an existing codebase like a new engineer, then asks about what is still unclear |
| `context` | files knowledge from the conversation into the right `.ai/` files |
| `review` | reviews the pending diff, unpushed commits, linters, and tests |
| `ship` | prepares a commit: verifies the staged diff, writes the message, runs the pre-commit checks |
| `ci` | runs lint, test, build, and security scan locally, then reports pass or fail |
| `extend-config` | creates or updates files in this repo following the authoring spec |

## Reference docs

`core/docs/` is shared across projects and never copied into one. The table
below lists the docs people reach for most; `AGENTS.md` section 3 is the entry
point and names every shared doc with its path.

| Doc | Covers |
|---|---|
| `development-workflow.md` | the three workflow phases and the gate that ends each |
| `validation-checklist.md` | what to verify before declaring a task complete |
| `coding-standards.md` | naming, comments, error handling, refactoring rules |
| `testing.md` | unit, integration, and end-to-end tests, conventions, CI commands, quality gates |
| `git-workflow.md` | branches, commits, pull requests, and identity resolution |
| `security.md` | authentication, input validation, secrets, dependency review triggers |
| `onboarding.md` | procedure for entering an existing project |
| `ai-directory.md` | the `.ai/` structure standard |
| `project-docs.md` | the committed `docs/` and README standard |
| `agent-config-authoring.md` | how to add rules, skills, docs, and templates to this repo |
| `ai-writing.md` | prose rules for anything a human reads |
| `evals.md` | the retained eval set that gates changes to the shared rules |
| `sources.md` | where each rule, threshold, and design choice came from |

`core/docs/repository-map.md` describes the full layout, including the language
guides in `core/docs/languages/` and the ADR template in `core/docs/decisions/`.

## Git identity

Identity is per machine, never tracked:

- `~/.config/git/identity` holds your `user.name` and `user.email`, mode 600.
- `~/.gitconfig` includes it conditionally for `~/Projects/**` and `~/.config/**`,
  so personal and work directories can resolve differently.
- `setup.sh` creates the file from your existing global config if it is missing.

Auth stays at the SSH level and out of git config. `core/docs/git-workflow.md`
covers the resolution order.

## Extending the config

1. Load `core/docs/agent-config-authoring.md`, or run the `extend-config` skill.
2. Write the file following its format rules: imperative bullets for rules,
   numbered steps for skills, headers and bullets for reference docs.
3. Run the wiring checklist: new docs go into `AGENTS.md` section 3, structure
   changes into `core/docs/repository-map.md`, new claims into
   `core/docs/sources.md`.
4. Commit with a conventional message, staging explicit files only.

## Validation

Run before finishing any change to this config:

```bash
for f in setup.sh ai-init ai-context agents/dsh/install.sh; do bash -n "$f"; done  # shell syntax
for f in agents/dsh/presets/renks/*.mjs; do node --check "$f"; done                # plugin syntax
find . -type l ! -exec test -e {} \; -print                                        # broken symlinks
```

Each check needs its own loop: `bash -n` and `node --check` only inspect the
first file they are given.

Skill frontmatter needs `name`, `description`, and `whenToUse`, with `name`
matching the directory. Rule frontmatter needs `description`, `globs`, and
`paths`. The dsh patch flow keeps
`agents/dsh/presets/renks/stock-baseline.agent.cordis.yml` plus
`agent.cordis.patch` byte-identical to `fallback.agent.cordis.yml`; see
`agents/dsh/presets/renks/README.md`.

Prose in the README, docs, comments, and commit messages is checked against
`core/docs/ai-writing.md`.

## Status

Used daily on this machine across Claude Code, Cursor, and dsh. The dsh preset
tracks whichever dsh version is installed through a patch instead of freezing a
copy of the upstream recipe. Changes to the default preset or the shared rules
run against the retained eval set in `core/docs/evals.md` first.

## License

MIT. See `LICENSE`.
