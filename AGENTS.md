# AGENTS.md - v2026-08-03

## Scope and ownership
- This configuration is the single source of truth for agent behavior. It is READ-ONLY: never create, edit, or delete anything under `~/.config/agent-config/`.
- A project's agent configuration lives in its `.ai/` directory. `.ai/agents.md` is a symlink to this file - shared, identical in every project, updated automatically when this config changes. `.ai/project.md` holds project-specific rules. The `.ai/` structure is defined in `~/.config/agent-config/docs/ai-directory.md`.
- Custom, project-specific instructions belong only in `.ai/project.md` and `.ai/docs/`. Never adapt shared rules to fit one project - override in the project instead.

## Section 0: Non-Negotiables
1. No flattery. Never say "Great question," "Good catch," or similar. Be direct.
2. Always explain what you did. After any change, state: what files, what was changed, why.
3. Disagree when evidence contradicts. State the conflict and your confidence level.
4. Never fabricate. If you don't know, say so. Don't guess and sound certain.
5. Stop when confused. Ask. Don't barrel ahead with wrong assumptions.
6. Touch only what's requested. No drive-by refactoring. No cleanups outside scope.
7. Formatting by audience: agent-facing files (this config, `.ai/`) are AI-only - headers and bullets, no bold, no tables, no decorative markdown. Committed project docs (`README.md`, `docs/`) are written for humans - full markdown.

## Section 1: Project entry
1. Load `.ai/project.md` first - project rules, build/test/lint commands, conventions.
2. This file is the shared config, symlinked into every project as `.ai/agents.md`.
3. On first entry, classify the project:
   - NEW - empty, scaffold-only, no build history. Propose `ai-init`, fill `.ai/project.md` and project context, then plan the build-out.
   - EXISTING - has source, build files, or commit history. Onboard like a new employee before any change: survey `docs/repository-map.md` and `.ai/context/index.md`, review git history, then ask targeted questions about anything unclear - business rules, database, conventions, hidden context. Follow the full procedure in `~/.config/agent-config/docs/onboarding.md`. Never re-create, restructure, or "improve" what already works.
4. Read state before acting: `.ai/session.md` (current state), `.ai/assumptions.md` (decision log), `.ai/scratchpad.md` (working notes), `.ai/context/index.md` (project knowledge base - domain, architecture, database, dependencies, conventions).
5. Capture project knowledge as it is confirmed - from the user's words or your exploration - into the matching file: `.ai/context/domain.md` (purpose, business rules, glossary), `database.md` (schema, storage), `dependencies.md` (external services), `conventions.md` (local rules), `.ai/project.md` (stack, build/test, conventions), `.ai/assumptions.md` (decisions). Replace the open questions in the topic files with the confirmed facts. Never put facts in `.ai/context/index.md` - it is machine-owned.
6. Consult `.ai/context/` and `.ai/docs/` for project-specific knowledge and the repository's `docs/` for technical documentation.
7. Generate `README.md` and context topic files on demand with `ai-context` - driven by detected project context, only sections that apply (no database docs in a project without a database). Never copy generic templates into the project.
8. When creating agent-facing `.md` files (`.ai/`), follow `~/.config/agent-config/docs/ai-directory.md` and start from `~/.config/agent-config/templates/convention-doc.md`. Project docs (`README.md`, `docs/`) follow `~/.config/agent-config/docs/project-docs.md` and are formatted for humans.
9. Commit only after human approval.

## Section 2: Workflow (CRISPY)
### Analysis
1. Read the project's `docs/repository-map.md` for structure; if absent, use `~/.config/agent-config/docs/repository-map.md`.
2. Load `~/.config/agent-config/skills/RULES.md` for behavior rules.
3. State a numbered implementation plan with explicit success criteria before any code.
4. Document assumptions in `.ai/assumptions.md`.
5. Generate the root `README.md` on demand with `ai-context` - enterprise overview with only the sections that apply; deep documentation lives in `docs/` (standard: `~/.config/agent-config/docs/project-docs.md`).

### Implementation
1. Surgical changes only - every diff line traces to the request
2. Test-first: write failing test → implement → verify pass → refactor
3. Complete code: every function handles errors, logs operations, covers edge cases. Minimum viable means minimum scope, not minimum quality.
4. Complexity budgets: cyclomatic ≤10, cognitive ≤15, params ≤4, depth ≤3, lines ≤60, file ≤500. Complex code is agent drag - expensive for both humans and agents to navigate. Enforce in CI; do not increase total repository complexity without justification.
5. One task at a time. Finish, confirm, next.
6. Time-box: 3 tries or 5 minutes for simple issues. For complex bugs, investigate deeper - don't patch blindly.
7. Run linters after edits. Fix all warnings.
8. Run tests. All must pass.

### Review
1. Self-review the diff for unintended changes
2. Run the validation checklist - `~/.config/agent-config/docs/validation-checklist.md` (a project `docs/validation-checklist.md` overrides it)
3. Working code is a first draft. After tests go green, do one ruthless edit of your own diff - remove dead code, abstractions, debug artifacts.
4. Never `git add -A`. Stage explicit files only.

## Section 3: Reference docs - shared, read on demand
Read on demand; never copy them into projects.
- `.ai/` structure: `~/.config/agent-config/docs/ai-directory.md`
- Onboarding: `~/.config/agent-config/docs/onboarding.md`
- Project docs standard: `~/.config/agent-config/docs/project-docs.md`
- Git/Commits: `~/.config/agent-config/docs/git-workflow.md`
- Architecture: `~/.config/agent-config/docs/architecture.md`
- Code Style: `~/.config/agent-config/docs/coding-standards.md`
- Testing: `~/.config/agent-config/docs/testing.md`
- Security: `~/.config/agent-config/docs/security.md`
- Complexity: `~/.config/agent-config/docs/complexity.md`
- Coupling: `~/.config/agent-config/docs/coupling.md`
- Debugging: `~/.config/agent-config/docs/debugging.md`
- Maintainability: `~/.config/agent-config/docs/maintainability.md`
- Performance: `~/.config/agent-config/docs/performance.md`
- Languages: `~/.config/agent-config/docs/languages/`
- Decisions: `~/.config/agent-config/docs/decisions/`
- Dependencies: `~/.config/agent-config/docs/dependency-policy.md`

## Section 4: Memory files (`.ai/`, local-only, never committed)
- `.ai/agents.md` - symlink to this file (shared; do not edit)
- `.ai/project.md` - project-specific rules (stack, build/test/lint, conventions)
- `.ai/session.md` - current session state
- `.ai/assumptions.md` - decision log
- `.ai/scratchpad.md` - working notes
- `.ai/docs/` - project-specific convention docs
- `.ai/context/` - project knowledge base (domain, architecture, database, dependencies, conventions)
- Never commit `.ai/`; it is per-project knowledge, not project content.

## Section 5: No-Go
- No new dependencies without approval (see `~/.config/agent-config/docs/dependency-policy.md`)
- No speculative abstractions - don't build for imagined futures
- No interfaces solely for mocking
- No rewriting working code during feature changes

## Section 6: Tool Usage
- Prefer dedicated search/read tools over shell commands for file access:
  - In-project text search → `grep_search` (not shell `grep`)
  - In-project file discovery → `file_search` (not `ls`/`find`)
  - Reading files (any path, incl. outside the CWD) → `read_file` (not `cat`/`head`/`tail`)
  - Git state/diff review → `get_changed_files` (not `git diff`)
  - New files → `create_file` (not shell redirection)
  - Rationale: pre-approved in codecompanion (silent - no approval prompts), scoped/bounded output, respects gitignore.
- Use `run_command` only when no dedicated tool exists: `ls`/`find` listings outside the CWD, git operations beyond diff, builds/tests, system inspection.
- Search once, search well: one precise query beats repeated similar ones; read only the line ranges needed.
- Web search (`web_search`) is a last resort, not a first move:
  - Consult local sources first: this config's `docs/`, `.ai/context/`, `.ai/docs/`, the repo's `docs/`, and files already read.
  - Use `web_search` only for what local sources cannot answer: current versions/changelogs of external dependencies, upstream breaking changes, official API docs, and errors that require external knowledge.
  - Never use `web_search` for: project conventions or formatting rules defined in this config, markdown/config structure (use `~/.config/agent-config/templates/` and the docs), or to backfill facts you do not actually know.
  - Cite the source and retrieval date for any fact taken from the web.
