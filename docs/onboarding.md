# Onboarding - First Steps in an Existing Project

Shared workflow for onboarding into an already-working codebase. Applies to EXISTING projects only; empty or scaffold-only repos take the ai-init path instead. Read on demand; never copy into projects.

## Purpose
One deterministic, read-first-then-ask procedure to understand an existing codebase, then capture confirmed knowledge in `.ai/` before any change is made.

## Workflow
1. Classify before acting - confirm EXISTING (source, build files, or commit history). NEW/empty repos go through ai-init, not this flow.
2. Read state - `.ai/project.md`, `.ai/session.md`, `.ai/assumptions.md`, `.ai/context/index.md` if present; root `README.md`; `docs/repository-map.md`.
3. Survey, read-only - top-level structure, entry points, manifest files, CI config, test locations. No code edits in this phase.
4. Map the system - module layout, data flow, external boundaries, change points and seams. Draft `docs/repository-map.md` if absent (human-formatted, committed).
5. Ask, never presume - run the question checklist below. Batch by topic; wait for answers before the next batch.
6. Capture confirmed facts - fill `.ai/project.md` and `.ai/context/` topic files; log decisions in `.ai/assumptions.md`.
7. Verify understanding - run build, tests, lint; trace one end-to-end request through the code; state back a summary and get confirmation before any change.

## Question checklist - ask until answered, never assume
- Branches and git - naming scheme, protected branches, where features branch from, merge strategy.
- Pull requests - required checks, reviewers, squash vs merge, title and description conventions.
- Environments - dev, QA, staging, prod: how to run each, config sources, secrets location, who has access.
- Domain - what the system does, business rules, glossary terms.
- Database and storage - engines, schema source, migrations, backup and restore.
- External services - APIs, message queues, auth providers, cron jobs.
- Build, test, lint - exact commands; confirm against CI config, not just manifests.
- Conventions - code style, commit style, doc locations, any local rules not yet in `.ai/`.
- Deployment and releases - how code ships, versioning, rollback.
- Ambiguities - every code path whose intent is not explicit; ask rather than infer.

## Output - files to write as facts are confirmed
- `.ai/project.md` - stack, build/test/lint, conventions.
- `.ai/context/domain.md`, `architecture.md`, `database.md`, `dependencies.md`, `conventions.md` - create only the files that apply; replace open questions with confirmed facts.
- `.ai/assumptions.md` - one numbered entry per decision.
- Never write facts into `.ai/context/index.md` - it is machine-owned.

## Rules
- Never presume business rules, workflow, or architecture; when the code does not make them explicit, ask.
- Never edit code during onboarding; it is read-only until understanding is confirmed.
- Never fabricate; record unknowns as open questions, not guesses.
- Do not dump all questions at once; batch by topic and wait for answers.
- Create only the context files that apply; no `database.md` without a database.
- Keep `.ai/docs/` lean; reference shared docs instead of duplicating them.
- Treat untested code as legacy; note characterization-test targets for later, but do not write tests during onboarding.

## Pointers
- `.ai/` structure: `ai-directory.md`
- Repo map: `repository-map.md`
- Git and PR: `git-workflow.md`
- Project docs: `project-docs.md`
- Behavior rules: `../skills/RULES.md`
