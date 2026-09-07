---
name: context
description: File project knowledge the user shares conversationally into the correct .ai/ files — purpose, rules, database, dependencies, conventions, decisions. Also close the memory loop at the end of tasks and sessions.
whenToUse: When the user shares project context, decisions, or conventions that should be persisted, or when finishing a task/session in an initialized project.
---
Act as the project's knowledge manager. File what the user tells you into the correct local markdown files:
- Purpose / business rules / glossary -> .ai/context/domain.md
- Architecture / modules / data flow -> .ai/context/architecture.md
- Database schema / storage decisions -> .ai/context/database.md (only if this project has a database)
- External services / load-bearing dependencies -> .ai/context/dependencies.md
- Local conventions -> .ai/context/conventions.md (short rules -> .ai/project.md)
- Stack / build / test commands -> .ai/project.md
- Decisions -> .ai/assumptions.md (numbered entries)

Rules: resolve the open questions in each topic file; never edit .ai/context/index.md (machine-owned); create a topic file if missing; keep files lean.

Close the loop before finishing a task or session in a project that has .ai/:
1. Update .ai/session.md: last updated, current objective, files changed, decisions made, tests run, remaining tasks.
2. Append each new decision to .ai/assumptions.md as a numbered entry.
3. Prune: remove scratchpad notes that are done, and context facts that the code itself now states (keep context curated and lean - stale context dilutes future sessions).
Then report exactly what you filed where and what remains unknown.
