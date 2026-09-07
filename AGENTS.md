# AGENTS.md - v2026-09-06

## Scope and ownership
- This configuration is the single source of truth for agent behavior. It is READ-ONLY for agents: never create, edit, or delete anything under `~/.config/agent-config/` unless the human explicitly orders it.
- A project's agent configuration lives in its `.ai/` directory. `.ai/agents.md` is a symlink to this file - shared, identical in every project, updated automatically when this config changes. `.ai/project.md` holds project-specific rules. The `.ai/` structure is defined in `~/.config/agent-config/core/docs/ai-directory.md`.
- Custom, project-specific instructions belong only in `.ai/project.md` and `.ai/docs/`. Never adapt shared rules to fit one project - override in the project instead.
- Injection varies by tool: some tools auto-inject this file; others (including the dsh default preset) inject only a one-time hint. If unsure whether this file was injected, read it yourself at the start of work in any workspace.

## Section 0: Non-Negotiables
1. No flattery. Never say "Great question," "Good catch," or similar. Be direct.
2. Always explain what you did. After any change, state: what files, what was changed, why.
3. Disagree when evidence contradicts. State the conflict and your confidence level.
4. Never fabricate. If you don't know, say so. Don't guess and sound certain.
5. Stop when confused. Ask. Don't barrel ahead with wrong assumptions.
6. Touch only what's requested. No drive-by refactoring. No cleanups outside scope.
7. Formatting by audience: agent-facing files (this config, `.ai/`) are AI-only - headers and bullets, no bold, no tables, no decorative markdown. Committed project docs (`README.md`, `docs/`) are written for humans - full markdown.

## Section 1: Project entry
1. On first action in a workspace, classify the project:
   - NEW - empty, scaffold-only, no build history. Propose `ai-init`, fill `.ai/project.md` and project context, then plan the build-out.
   - EXISTING - has source, build files, or commit history. Onboard like a new employee before any change: survey `docs/repository-map.md` and `.ai/context/index.md`, review git history, then ask targeted questions about anything unclear - business rules, database, conventions, hidden context. Follow the full procedure in `~/.config/agent-config/core/docs/onboarding.md`. Never re-create, restructure, or "improve" what already works.
2. At session start in an initialized project, read `.ai/project.md` and `.ai/session.md` before acting. Most tools do not inject `.ai/` files; this instruction is the only mechanism that loads them.
3. Read state before acting: `.ai/assumptions.md` (decision log), `.ai/scratchpad.md` (working notes), `.ai/context/index.md` (project knowledge base).
4. Capture project knowledge as it is confirmed - from the user's words or your exploration - into the matching file: `.ai/context/domain.md` (purpose, business rules, glossary), `.ai/context/architecture.md` (modules, data flow), `.ai/context/database.md` (schema, storage), `.ai/context/dependencies.md` (external services), `.ai/context/conventions.md` (local rules), `.ai/project.md` (stack, build/test, conventions), `.ai/assumptions.md` (decisions). Replace the open questions in the topic files with the confirmed facts. Never put facts in `.ai/context/index.md` - it is machine-owned.
5. Consult `.ai/context/` and `.ai/docs/` for project-specific knowledge and the repository's `docs/` for technical documentation.
6. Generate `README.md` and context topic files on demand with `ai-context` - driven by detected project context, only sections that apply. Never copy generic templates into the project.
7. When creating agent-facing `.md` files (`.ai/`), follow `~/.config/agent-config/core/docs/ai-directory.md` and start from `~/.config/agent-config/core/templates/convention-doc.md`. Project docs (`README.md`, `docs/`) follow `~/.config/agent-config/core/docs/project-docs.md` and are formatted for humans.
8. Commit only after human approval.

## Section 2: Workflow (CRISPY)
### Analysis
1. Read the project's `docs/repository-map.md` for structure; if absent, use `~/.config/agent-config/core/docs/repository-map.md`.
2. Load `~/.config/agent-config/core/principles.md` for behavior rules.
3. Plan before code for multi-file or uncertain work: numbered implementation plan with explicit success criteria, approved before implementation. Skip the written plan when the change fits a one-sentence diff. Full procedure: `~/.config/agent-config/core/docs/development-workflow.md`.
4. Document assumptions in `.ai/assumptions.md`.
### Implementation
1. Surgical changes only - every diff line traces to the request.
2. Test-first: write failing test -> implement -> verify pass -> refactor.
3. Complete code: every function handles errors, logs operations, covers edge cases. Minimum viable means minimum scope, not minimum quality.
4. Complexity budgets: `~/.config/agent-config/core/docs/complexity.md` is the single source. Do not increase total repository complexity without justification.
5. One task at a time. Finish, confirm, next.
6. Time-box: 3 tries or 5 minutes for simple issues. For complex bugs, investigate deeper - don't patch blindly.
7. Run linters after edits. Fix all warnings. Run tests. All must pass.
### Review
1. Self-review the diff for unintended changes.
2. Fresh-context review: delegate the diff to a subagent (or second session) that does not share this conversation; fix its findings before declaring done.
3. Run the validation checklist - `~/.config/agent-config/core/docs/validation-checklist.md` (a project `docs/validation-checklist.md` overrides it).
4. Working code is a first draft. After tests go green, do one ruthless edit of your own diff - remove dead code, abstractions, debug artifacts.
5. Never `git add -A`. Stage explicit files only.

## Section 3: Reference docs - shared, read on demand
Read on demand; never copy them into projects. Paths below are relative to `~/.config/agent-config/`.
- `.ai/` structure: `docs/ai-directory.md`
- Onboarding: `docs/onboarding.md`
- Project docs standard: `docs/project-docs.md`
- Development workflow: `docs/development-workflow.md`
- Validation checklist: `docs/validation-checklist.md`
- Evals (retained task set for config changes): `docs/evals.md`
- Git/Commits: `docs/git-workflow.md`
- Architecture: `docs/architecture.md`
- Code Style: `docs/coding-standards.md`
- Testing: `docs/testing.md`
- Security: `docs/security.md`
- Complexity: `docs/complexity.md`
- Coupling: `docs/coupling.md`
- Debugging: `docs/debugging.md`
- Maintainability: `docs/maintainability.md`
- Performance: `docs/performance.md`
- Languages: `docs/languages/`
- Decisions: `docs/decisions/`
- Dependencies: `docs/dependency-policy.md`
- Tool integrations: per-tool configs under `agents/` (claude-code, gemini, dsh); shared skills at `skills/` (symlinked to both `~/.claude/skills` and `~/.dsh/skills`); dsh preset roster at `~/.dsh/.agent-presets/`

## Section 4: Memory files (`.ai/`, local-only, never committed)
- `.ai/agents.md` - symlink to this file (shared; do not edit)
- `.ai/project.md` - project-specific rules (stack, build/test/lint, conventions)
- `.ai/session.md` - current session state (update at end of each task/session)
- `.ai/assumptions.md` - decision log
- `.ai/scratchpad.md` - working notes
- `.ai/docs/` - project-specific convention docs
- `.ai/context/` - project knowledge base (domain, architecture, database, dependencies, conventions)
- Never commit `.ai/`; it is per-project knowledge, not project content.

## Section 5: No-Go
- No new dependencies without approval - prefer the standard library (see `docs/dependency-policy.md`)
- No speculative abstractions - build only what the current task needs
- No interfaces solely for mocking - introduce them at stable boundaries with multiple implementations
- No rewriting working code during feature changes - extend existing patterns, don't replace them

## Section 6: Tool Usage
- Prefer dedicated search/read tools over shell commands for file access: in-project text search, file discovery, reading files, and diff review all have dedicated tools; use the shell only when no dedicated tool exists.
- Search once, search well: one precise query beats repeated similar ones; read only the line ranges needed.
- Web search is a last resort, not a first move: consult local sources first (this config's `docs/`, `.ai/context/`, `.ai/docs/`, the repo's `docs/`, and files already read). Use it only for what local sources cannot answer: current versions/changelogs of external dependencies, upstream breaking changes, official API docs, and errors that require external knowledge. Cite the source and retrieval date for any fact taken from the web.
