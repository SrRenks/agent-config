# Development Workflow (CRISPY Methodology)

Based on the Research → Plan → Implement methodology, structured as Analysis → Implementation → Review.

## Analysis Phase (Before Coding)
1. Survey - inspect repository structure, README, build config
2. Understand - identify affected components and dependencies
3. Plan - create a numbered implementation plan before writing any code
4. Document assumptions - in `.ai/assumptions.md` (Declared Intent + Desired Output)
5. Define success criteria - explicit, verifiable outcomes, not "make it work"

### Gate: Plan must be approved before proceeding to implementation.

## Implementation Phase
1. Surgical changes - touch only lines related to the task; no drive-by refactoring
2. Test-first (write-test-run-fix) - write a failing test or CLI command *before* implementing. This applies to both bug fixes *and* new features. The loop: write test → see it fail → implement → see it pass → refactor. (See `docs/testing.md` for test conventions.)
3. Complexity budget enforcement - check every modified function against `docs/complexity.md`. If any exceeds budgets, simplify before continuing.
4. One task at a time - finish, confirm, then move on. No context switching.
5. Time-box failures - 3 tries or 5 minutes maximum per problem. If unresolved, escalate.
6. Run linters - fix all warnings before proceeding
7. Run tests - ensure all pass

### Gates
- Complexity budget check must pass before review
- Linters must pass with zero warnings
- Tests must pass with zero failures

### Review Phase (After Coding)
1. Self-review - review your own diff for unintended changes
2. Working code is a first draft - after tests go green, do one ruthless edit of your own diff. Remove unnecessary abstractions, dead code, debug artifacts, speculative generality.
3. Verification gates - run through `docs/validation-checklist.md`:
   - ☐ Tests pass
   - ☐ Linters pass
   - ☐ Complexity budgets met (document exceptions)
   - ☐ No new dependencies without approval
   - ☐ Docs updated if behavior changed
   - ☐ No unintended changes in diff
4. Get approval - show draft, get OK, then commit

## Commit Rules
- Never `git add -A` - stage explicit file paths only
- Write descriptive commit messages (what and why)
- Never commit with failing tests or lint warnings
- Never force-push to shared branches

## Exception Policy
- Complexity exceptions: documented with a justification in the commit
- Breaking changes: documented with a migration plan
- New dependencies: approved and justified (see `docs/dependency-policy.md`)

## Key Principles (from AGENTS.md)
- Think before coding - plan first, code second
- Minimum viable code - solve the problem, not the imagined future
- No sycophancy - disagree when evidence contradicts
- Pushback scales with certainty - probe harder when user sounds confident