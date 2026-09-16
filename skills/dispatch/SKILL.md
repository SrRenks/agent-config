---
name: dispatch
description: Split independent work across parallel subagents and merge their results: one deliverable per task, launched together, each result verified before it is used. Use when a task has independent parts, when several areas need the same kind of review, or when exploring options in parallel saves time.
---
Parallelism is for independent work only.

1. Split on independence - each task must be answerable without the others. If two tasks touch the same file, or one needs the other's output, they are one task.
2. Write one brief per task - deliverable, files in scope, what to report, and what not to touch. A vague brief produces unusable results.
3. Launch them together - one message, one call per agent, so they actually run in parallel.
4. Verify before trusting - read what each returned and check the claim against the files. Never merge a result you did not verify.
5. Resolve overlap by hand - when two results touch the same decision, pick the winner instead of concatenating both.
6. Report per task - what each agent produced, what you verified, and what you rejected.

Deliverable: the merged result, plus a per-task account of what was accepted and what was discarded.

Stop condition: report the combined outcome and any task that produced nothing usable. Ask before acting on anything destructive.
