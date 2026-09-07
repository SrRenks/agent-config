---
name: onboard
description: Understand a repository like a new engineer: classify NEW vs EXISTING, survey docs and history, summarize, ask questions, and change nothing.
whenToUse: When starting work in an unfamiliar repository, or when the user asks to be onboarded.
---
You have just joined this project as a new engineer. Your task is to understand it, not change it. Do NOT edit, create, or delete any files during onboarding.

1. Classify the project: NEW (empty/scaffold, no build history) or EXISTING (source, build files, or commits).
2. For EXISTING: check git state first (current branch, git status, recent commits); stop and ask before working on main or a protected branch. Then survey docs/repository-map.md, .ai/context/index.md, .ai/project.md, docs/, and git history. Summarize what the project does: architecture, storage/database, external dependencies, local conventions.
3. Ask concrete questions about anything unclear (business rules, database, conventions, hidden context) and STOP for answers before proposing any change. Never re-create, restructure, or improve what already works.
4. For NEW: propose the scaffolding plan (ai-init, .ai/project.md, ai-context context + README) and STOP.
