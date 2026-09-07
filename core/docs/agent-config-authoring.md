# Agent-config authoring spec (v2026-09-07)

Purpose: how to create or extend files in this repo when the human explicitly orders it. The config is READ-ONLY otherwise (AGENTS.md, Scope section). Load this spec, then follow it exactly.

## Where each thing goes
- core/docs/<topic>.md - reference doc, read on demand, listed in AGENTS.md section 3
- core/docs/languages/<lang>.md - language guidelines (tooling, linter config, practices)
- agents/claude-code/rules/<lang>.md - scoped rules with dual frontmatter, short imperative bullets
- skills/<name>/SKILL.md - a procedure the agent runs on demand
- core/templates/<file> - skeletons copied into projects by ai-init and ai-context
- agents/dsh/presets/renks/ - dsh preset (patch flow; see its README.md)
- setup.sh - machine bridges (symlinks); README.md - human overview; core/docs/repository-map.md - structure doc

## File formats (follow exactly)

Rules, agents/claude-code/rules/<lang>.md:
---
description: One sentence, what these rules cover.
globs: "**/*.go"
paths:
  - "**/*.go"
---
- Imperative bullets only, 5 to 20 lines, no prose paragraphs.
description and globs serve Cursor; paths serves Claude Code. Keep both keys when adding or editing a rule.

Skills, skills/<name>/SKILL.md:
---
name: kebab-case, equal to the directory name
description: One sentence: what the skill does and when to use it.
whenToUse: When the user ... (trigger phrases)
---
- Body: numbered imperative steps; state the deliverables; end with a stop condition (wait for approval or report).
- Never duplicate a procedure that already exists; extend the existing skill instead.
- Keep bodies lean. A loaded skill occupies context, so every line must pay rent.

Reference docs, core/docs/*.md:
- Agent-facing format: headers and bullets only; no bold, no tables, no em dashes, no decorative markdown (AGENTS.md rule 16).
- One topic per file. Order: purpose, rules, procedure.

Language docs, core/docs/languages/<lang>.md:
- Sections: Tooling, Recommended Linter Configuration, Practices. Mirror go.md.
- Agent-facing format (the agent reads them while coding).

Templates:
- Start from the closest existing template. Keep placeholders minimal and named.

## Wiring checklist (run after creating any file)
1. New reference doc: add one line to AGENTS.md section 3.
2. New tool bridge or top-level dir: update setup.sh symlinks plus the README layout and matrix.
3. Structure changes: update core/docs/repository-map.md.
4. New skill: nothing else needed (auto-discovered by dsh and Claude Code through the skills/ symlinks).
5. New rule: nothing else needed (auto-loaded by Claude Code and Cursor).
6. Preset changes: follow the agents/dsh/presets/renks/README.md patch flow; run the retained eval set (core/docs/evals.md) before changing defaults.
7. Commit: conventional message, plain wording, explicit files only, never git add -A. Wait for human approval before committing (AGENTS.md section 1 rule 8).

## Validation before finishing
- Scripts: bash -n <file>.
- Preset YAML: node -e "require('yaml').parse(...)" run from ~/.dsh/profiles; the !!js tag warnings are expected.
- Patch integrity: apply agent.cordis.patch to stock-baseline.agent.cordis.yml and diff against fallback.agent.cordis.yml; must be byte-exact.
- Skill frontmatter: name, description, whenToUse present; name equals the directory.
- Rule frontmatter: description, globs, paths present.
- Symlinks: find . -type l ! -exec test -e {} \; -print must return nothing.
- Human-facing prose: scan against core/docs/ai-writing.md and fix the tells.

## Procedure
1. Classify the request: rule, skill, doc, template, preset, or bridge.
2. Read the closest existing file of that type and copy its structure.
3. Write the file following the format rules above.
4. Run the wiring checklist.
5. Run the validation list.
6. Report what was created, where it is wired, and what remains unverified.
