# Complexity Budgets

## Rationale

Complex code is agent drag - it is expensive for both humans and AI agents to
navigate, understand, and modify. Studies of AI-assisted repositories show
cognitive complexity rising by ~41% across iterations unless explicitly
controlled. These budgets counteract that drift.

Code that is ergonomic for AI is also better for humans.

## Metrics

Enforce these default complexity budgets:

- Cyclomatic Complexity: ≤ 10 per function.
- Cognitive Complexity: ≤ 15 per function.
- Function Length: ≤ 60 lines of code.
- File Length: ≤ 500 lines of code.
- Nesting Depth: ≤ 3 levels.
- Number of Parameters: ≤ 4.

Treat these limits as defaults, not absolute rules.

Allow exceptions only when:
- splitting reduces readability
- abstraction introduces unnecessary indirection
- performance requires locality

Document the reason whenever a limit is exceeded.

## Design Principles
- Use composition over inheritance.
- Never write speculative abstractions.
- Do not introduce interfaces solely for mocking.
- Introduce abstractions when they represent a stable boundary or multiple implementations.
- Delete code instead of adding abstractions whenever possible.

## Enforcement
- CI should warn or reject violations depending on severity.
- Complexity exceptions are acceptable when documented and justified.
- CI should run language-native quality tooling (see `docs/languages/*.md` for detailed configuration). Use linters that enforce complexity budgets, nesting limits, and duplication detection.
- If complexity is unavoidable, document why and get approval.

## Repository-Level Complexity

Even if individual functions stay within limits, the repository as a whole can degrade over time. Therefore:

- Do not increase the total cognitive or cyclomatic complexity of the repository without a strong reason.  
- Large architectural changes that increase complexity must be broken into smaller, reviewable changes, and each must include a plan to refactor existing code to keep overall complexity stable or reduced.
- Use CI to track aggregate complexity metrics (e.g., sum of cognitive complexity across all functions). If the total increases by more than 5% in a single PR, the PR should include a justification.

Rationale: This prevents the "death by a thousand cuts" - many small, individually acceptable changes that accumulate into an unmaintainable codebase.
