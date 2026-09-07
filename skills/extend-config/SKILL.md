---
name: extend-config
description: Create or update files in the agent-config repo (rules, skills, docs, templates, presets, bridges) following its authoring spec.
whenToUse: When the user asks to add, extend, or reorganize the agent-config repo, or to create new agent config files such as language rules, skills, docs, or templates following the existing patterns.
---
1. Read ~/.config/agent-config/core/docs/agent-config-authoring.md and follow it exactly.
2. Classify the requested change; read the closest existing file of that type and copy its structure.
3. Create or edit following the spec's format rules; run its wiring checklist and validation list.
4. Never commit without explicit human approval (AGENTS.md section 1 rule 8). Report what was created, where it is wired, and what remains unverified.
