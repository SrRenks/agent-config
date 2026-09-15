# Development workflow (CRISPY methodology)

Based on the Research → Plan → Implement methodology, structured as Analysis → Implementation → Review.

## Analysis phase (before coding)
1. Survey - inspect repository structure, README, build config
2. Understand - identify affected components and dependencies
3. Plan - for multi-file or uncertain work, create a numbered implementation plan before writing any code. Skip the written plan when the change fits a one-sentence diff.
4. Document assumptions - in `.ai/assumptions.md` (Declared Intent + Desired Output)
5. Define success criteria - explicit, verifiable outcomes, not "make it work"

### Gate
Go to implementation only after the plan is approved. Trivial one-sentence diffs skip the plan but still go through the review gates below.

## Implementation phase
1. Surgical changes - touch only lines related to the task; no drive-by refactoring
2. Test-first (write-test-run-fix) - write a failing test or CLI command *before* implementing. This applies to both bug fixes *and* new features. The loop: write test → see it fail → implement → see it pass → refactor. (See `core/docs/testing.md` for test conventions.)
3. Complexity budget enforcement - check every modified function against `core/docs/complexity.md`. If any exceeds budgets, simplify before continuing.
4. One task at a time - finish, confirm, then move on. No context switching.
5. Time-box failures - 3 tries or 5 minutes maximum per problem. If unresolved, escalate.
6. Run linters - fix all warnings before proceeding
7. Run tests - ensure all pass

### Gates
- Complexity budget check must pass before review
- Linters must pass with zero warnings
- Tests must pass with zero failures

### Review phase (after coding)
1. Self-review - review your own diff for unintended changes
2. Working code is a first draft - after tests go green, do one ruthless edit of your own diff. Remove unnecessary abstractions, dead code, debug artifacts, speculative generality.
3. Fresh-context review - delegate the diff to a subagent (or second session) that does not share this conversation; it hunts for bugs, overreach, missing tests, unintended changes; fix valid findings.
4. Verification gates - run through `core/docs/validation-checklist.md`:
   - [ ] Tests pass
   - [ ] Linters pass
   - [ ] Complexity budgets met (document exceptions)
   - [ ] No new dependencies without approval
   - [ ] Docs updated if behavior changed
   - [ ] No unintended changes in diff
   - [ ] Fresh-context review clean
5. Get approval - show draft, get OK, then commit
6. Close the memory loop - update `.ai/session.md` and append decisions to `.ai/assumptions.md` (see the `context` skill).

## Commit rules
- Never `git add -A` - stage explicit file paths only
- Write descriptive commit messages (what and why)
- Never commit with failing tests or lint warnings
- Never force-push to shared branches

## Exception policy
- Complexity exceptions: documented with a justification in the commit
- Breaking changes: documented with a migration plan
- New dependencies: approved and justified (see `core/docs/dependency-policy.md`)

## Config changes (presets, AGENTS.md, skills)
- Before changing the default dsh preset or the shared rules, run the retained eval set in `core/docs/evals.md` (anchor checks + task set) and compare success-rate-per-cost, not token counts.
- Never tune against public-benchmark scores; prefer self-hosted tasks.

## Key principles (from AGENTS.md)
- Think before coding - plan first, code second
- Minimum viable code - solve the problem, not the imagined future
- No sycophancy - disagree when evidence contradicts
- Pushback scales with certainty - probe harder when user sounds confident

Sources: `core/docs/sources.md`, sections "Agent behavior, context, and instructions" and "Internal, measured".
