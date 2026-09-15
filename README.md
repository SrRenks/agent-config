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

## The `.ai/` directory

Every project gets its own `.ai/`: the agent's working memory for that project,
local to the machine and never committed. This is the other half of the
read-only model. The shared config holds what is true for all projects, and
`.ai/` holds what is true for one of them.

```bash
cd ~/Projects/my-app
ai-init      # creates .ai/, links ./AGENTS.md, adds the .gitignore entry
ai-context   # writes context topic files and the project README, once the project has content
```

| Path | Role | Ownership |
|---|---|---|
| `.ai/agents.md` | symlink to this config's `AGENTS.md` | shared, never edited |
| `.ai/project.md` | stack, build/test/lint commands, local conventions | project |
| `.ai/session.md` | current session state, written at the end of a task | project |
| `.ai/assumptions.md` | decision log, one numbered entry per decision | project |
| `.ai/scratchpad.md` | working notes, commands, investigation results | project |
| `.ai/context/index.md` | maturity, stack, pointers, open gaps | machine, refreshed on every `ai-context` run |
| `.ai/context/<topic>.md` | domain, architecture, database, dependencies, conventions | created once, then never overwritten |
| `.ai/docs/` | project-specific convention docs, created on demand | project |

How it behaves:

- The shared rules arrive by symlink. Editing `AGENTS.md` here updates
  `.ai/agents.md` in every project at once, and no project keeps a copy to drift.
- `ai-init` also links `./AGENTS.md` in the project root, which is the path Codex,
  Cursor, Windsurf, Amp, Jules, and Claude Code look for.
- `.ai/` stays out of git. `ai-init` writes the entry into the project's
  `.gitignore`, so project knowledge never enters the repository's history and
  never reaches a teammate who does not need it.
- `ai-init` records project maturity. It reads git history and build files and
  stamps the result (NEW or EXISTING) into `context/index.md`, which decides
  whether the agent onboards first or starts building.
- Nothing is generated from a blank template. `ai-context` writes only the files
  that apply, so a project with no database gets no `database.md` and no storage
  row in the README.
- Files already written are left alone. `--force` refreshes only `index.md` and
  `README.md`, which keeps hand-written knowledge safe from a re-run.
- Topic files open with detected facts and explicit open questions. Answers
  replace the questions as they are confirmed, so the knowledge base grows out of
  real sessions instead of placeholders.
- Project rules win. When a project needs different behavior, the rule goes in
  `.ai/project.md`; shared rules never bend to fit one project.
- `.ai/` holds the agent's working memory for one project. Technical
  documentation that humans read, such as architecture and design decisions,
  belongs in the repository's committed `docs/` under the
  `core/docs/project-docs.md` standard. `.ai/docs/` holds only genuine deviations
  from the shared config; when the shared config already covers a convention,
  reference it instead of copying it.
- The memory loop closes at the end of a task: session state goes into
  `session.md`, new decisions append to `assumptions.md`, and finished notes are
  pruned from `scratchpad.md`, so the next session starts oriented.

`core/docs/ai-directory.md` is the full standard, including when a `.ai/docs/`
file is worth creating instead of a line in `project.md`.

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

## dsh and the `renks` preset

dsh (DeepSeek Harness) is the harness this config is tuned against. It runs the
agent loop locally, loads the shared rules from the `~/.dsh/AGENTS.md` symlink,
and discovers procedures from `~/.dsh/skills`, which points at `skills/`. It is
also the one tool here whose prompt composition can be patched, which is why the
leaner delivery lives in a dsh preset instead of in the shared rules.

The stock dsh recipe injects the full instruction files and the whole skill
catalog into the first request of every session. That spends context before any
work happens, and it moves the model's first step: the retained anchor checks
measured 0 of 9 first requests anchored with the catalog injected and about 81
percent without (`core/docs/evals.md`, issue #6).

The `renks` preset keeps the same rules and skills while removing both
injections:

| Stock behavior | Replaced by | What happens instead |
|---|---|---|
| `dsh-agent-instructions` inlines the `AGENTS.md` / `CLAUDE.md` digest | `instruction-hint.mjs` | one hint per session, after the first durable promotion signal: the instruction files exist, read them before acting |
| `dsh-tool-skill` injects the ~9KB `<available_skills>` catalog into the first step and again after every promotion or compaction | `skill-search.mjs` | `skill_search` lists matching names on demand, `skill_load` pulls one body; the catalog costs nothing until a task needs it |

`compaction-epoch.mjs` backs both plugins. It tracks the compaction boundary so a
promotion signal recorded before a compaction does not count after it. The two
plugins import only each other, never dsh internals, so an upstream release does
not break them.

A dsh update stays a merge, not a rewrite. The repo commits no copy of the stock
recipe; `agents/dsh/presets/renks/` holds three parts:

- `stock-baseline.agent.cordis.yml` is the frozen base the patch was made
  against, kept byte-identical as the merge base.
- `agent.cordis.patch` is the personal delta, the two swaps above.
- `fallback.agent.cordis.yml` is the last-known-good generated recipe.

`agents/dsh/install.sh` 3-way merges the patch onto whichever dsh version is
installed, validates the YAML, and installs the fallback when the merge
conflicts. It also links `~/.dsh/AGENTS.md` and `~/.dsh/skills` into this repo
and sets `agent-presets.default: renks` in `~/.dsh/settings.yaml`. After a dsh
upgrade:

```bash
git pull && bash agents/dsh/install.sh
```

On-demand search stays the default as the skill list grows. Injecting the catalog
only pays off while there are a handful of skills, so it should not come back
past roughly three to five.

## What agents are told

`AGENTS.md` is the contract every tool receives: 98 lines covering scope and
ownership, non-negotiables, project entry, the CRISPY workflow, memory files, the
no-go list, and tool usage. Read it directly for the rules; depth lives in
`core/docs/`, which agents load on demand.

## The workflow

The config names its workflow CRISPY, after the ZenML LLMOps Database entry cited
in `core/docs/sources.md`. The shape here is the earlier Research, Plan, Implement
method that entry evolved from: three phases, each ending in a gate.
`core/docs/development-workflow.md` has the detail.

- Analysis. Classify the project as NEW or EXISTING, survey the repository, and
  write a numbered plan with success criteria for anything multi-file or
  uncertain. Assumptions land in `.ai/assumptions.md`. Gate: the plan is approved
  before implementation starts.
- Implementation. One task at a time, tests written before the code, diffs that
  trace back to the request, complexity budgets checked as work proceeds, linters
  and tests clean before moving on. Gate: budgets, linters, and tests pass.
- Review. Self-review the diff, then one ruthless edit of your own diff to remove
  dead code, abstractions, and noise comments. The result goes to a fresh-context
  reviewer, a subagent or second session that does not share the conversation, to
  hunt bugs, overreach, and unintended changes. Then the validation checklist and
  the prose scan. Gate: human approval before the commit.

The separate context is the point of the review step: a reviewer working from the
same session inherits the author's assumptions.

## Guardrails

Claude Code gets two hooks, wired in `agents/claude-code/settings.json`:

- `block-danger` runs before a Bash call and denies a fixed list: recursive
  deletes, `sudo`, `git push --force`, `chmod 777`, raw disk writes (`dd`,
  `mkfs`, `> /dev/sda`), and `git add -A` or `git add .`, which the shared rules
  ban for every tool.
- `lint-check` is meant to report lint output after a file write or edit, for
  Python, Go, and Rust files whose linter is installed. As shipped it returns
  before linting: the hook compares `tool_name` against lowercase `write` and
  `edit`, while the matcher in `settings.json` says `Write|Edit`.

`session-init` is the one piece that waits to be asked for. It would create `.ai/`
wherever a session starts, which surprised projects that chose not to initialize,
so it ships unwired, with the snippet to wire it at the top of the file.
`claudeignore` is wired by `setup.sh` as `~/.claudeignore`: `.env` files, keys,
`credentials/`, `secrets/`, `*.tfstate`, `*.tfvars`, and build or vendor
directories are never opened.

`settings.json` also carries the permission lists. A set of routine commands is
pre-approved: builds, tests, git read commands, file inspection, and network
fetches. Denied outright: `git push`, every `rm`, `git add -A`, `sudo`,
`chmod 777`, `chown`, `shutdown`, `reboot`, `mkfs`, and `dd`.

The shared rules carry the git-add ban for every tool. The destructive-command
list lives only in the Claude Code hook and its settings, so other tools do not
inherit it.

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
| `sources.md` | where each rule, threshold, and design choice came from, by domain, with retrieval dates |

`core/docs/repository-map.md` describes the full layout, including the language
guides in `core/docs/languages/` and the ADR template in `core/docs/decisions/`.

`core/principles.md` sits outside `core/docs/` and holds the behavior rules an
agent loads before planning: Karpathy-style rigor plus operational rules such as
one task at a time and never committing without approval, complexity budgets, and
the anti-patterns list.

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
`core/docs/ai-writing.md`, which lists the vocabulary and sentence patterns that
make text read as machine output. It applies to prose written into files humans
read; chat replies and `.ai/` files are exempt.

The checklist an agent runs before declaring a task done is a separate document:
`core/docs/validation-checklist.md`.

## Status

Used daily on this machine across Claude Code, Cursor, and dsh. The dsh preset
tracks whichever dsh version is installed through a patch instead of freezing a
copy of the upstream recipe.

Changes to the default preset or the shared rules face the retained eval set in
`core/docs/evals.md` first: anchor checks that always run, plus a task set for
substantive work. The gate is that success rate does not drop and cost per solved
task does not rise materially. Public benchmark scores are not treated as
evidence.

## License

MIT. See `LICENSE`.

## Sources and acknowledgements

This config is assembled from other people's work. `core/docs/sources.md` records
every source with its retrieval date and what it backs, split between the sources
behind specific rules and the practitioner writing that shaped the stance. The
people below are the ones it leans on most.

- Fabio Akita (`akitaonrails`), for the position that AI-assisted work ships under
  the same review standard as any other code, and for `ai-memory`, an independent
  build of the same idea behind `.ai/`: agent memory as versioned markdown, with
  writes gated by evaluation.
- Robert C. Martin and Justin Martin. The function rules in Clean Code (small
  functions, one thing per function, few arguments, one level of abstraction)
  state in prose what this repo enforces in numbers; Clean Architecture covers
  dependency direction. Their Clean AI: Agentic Discipline series makes the
  argument the guardrails act on: discipline an agent cannot be trusted to
  remember belongs in the tooling.
- Andrej Karpathy, for the llm-rigor principles: think before coding, surgical
  changes, minimum viable code, and pushback that scales with certainty.
- HumanLayer, for the Research-Plan-Implement to CRISPY talk, which supplied the
  CRISPY name and phase structure, and the argument that always-on prompt budget
  is scarce.
- Anthropic, for Claude's Character and the sycophancy research behind the
  non-negotiables, the context engineering guidance behind the lean injection
  policy, and the skills pattern that `skill_search` mirrors.
- Matt Pocock, for publishing his own agent skills, a working reference for how a
  skill directory and its frontmatter should look.
- Martin Fowler and Kent Beck, for the test pyramid and self-testing code that the
  testing rules follow, and for writing about augmented coding as it develops.
- Thomas McCabe and G. Ann Campbell, for the two complexity metrics this repo
  budgets against, and the maintainers of `zj-karina/complexity-budget` for the
  numeric budgets themselves.
- Google, for the developer style guide, the engineering practices on code
  review, and the SRE postmortem culture.
- Simon Willison, for documenting in public what agent tooling does in practice,
  failure modes included.

Papers, standards, and studies behind the rest of the rules are listed in
`core/docs/sources.md`: among them the Wikipedia WikiProject AI Cleanup essay on
the signs of AI writing, the ETH Zurich study on instruction bloat and inference
cost, Diataxis, Keep a Changelog, Conventional Commits, the OWASP standards, and
the work of Parnas, Yourdon and Constantine, Feathers, Nygard, Knuth, and Chroma.
If a rule here misstates its source, or a source is missing, the fix belongs in
that file.
