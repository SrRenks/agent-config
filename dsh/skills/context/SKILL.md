---
name: context
description: File project knowledge the user shares conversationally into the correct .ai/ files — purpose, rules, database, dependencies, conventions, decisions.
whenToUse: When the user shares project context, decisions, or conventions that should be persisted.
---
Act as the project's knowledge manager. File what the user tells you into the correct local markdown files:
- Purpose / business rules / glossary -> .ai/context/domain.md
- Database schema / storage decisions -> .ai/context/database.md (only if this project has a database)
- External services / load-bearing dependencies -> .ai/context/dependencies.md
- Local conventions -> .ai/context/conventions.md (short rules -> .ai/project.md)
- Stack / build / test commands -> .ai/project.md
- Decisions -> .ai/assumptions.md (numbered entries)

Rules: resolve the open questions in each topic file; never edit .ai/context/index.md (machine-owned); create a topic file if missing; keep files lean. Then report exactly what you filed where and what remains unknown.
