# Maintainability Guidelines

## Duplication

- Eliminate unnecessary duplication, reuse existing functions, types, and utilities where appropriate.
- Do not duplicate logic across modules, extract a shared component only when logic is truly common.
- Accept duplication when abstraction would increase complexity, for example, two similar but conceptually different functions are better kept separate.
- When removing duplication, Do not create a “utility dumping ground”, each extracted unit must have a clear, single responsibility.

## Cohesion

Each module (package, crate, file) should have one clear responsibility and contain only code that directly supports that responsibility.

- Do not create ‘miscellaneous’ or ‘helpers’ packages – they become magnets for unrelated code.
- If a module grows beyond its original scope, split it into smaller, focused modules.
- Ensure that functions within a module are strongly related – they should collaborate toward a common purpose.

## Code Smells

The following code smells degrade maintainability and should be actively refactored:

- Long Method – > 60 lines (our complexity budget already caps this).
- Large Class – > 500 lines (our file length budget).
- Long Parameter List – > 4 parameters (our budget).
- Primitive Obsession – using primitive types where a small value object would clarify intent.
- Data Clumps – groups of data that always appear together; extract them into a class/struct.
- Feature Envy – a method that uses more data from another class than its own.
- God Object – a class that knows or does too much.
- Shotgun Surgery – a change that requires modifying many files; indicates poor cohesion.
- Message Chains – deep navigation chains (`a.b.c.d`), which indicate tight coupling.

Action:  
When you encounter these smells, refactor incrementally. Use automated tools (SonarQube, `golangci-lint`, Ruff) to detect them.

## Maintainability Measurement

Measure maintainability through concrete engineering signals:

- complexity budgets
- duplication detection
- dependency coupling
- module cohesion
- function and file size limits

Do not optimize code for abstract maintainability scores.
Prefer changes that reduce:
- unnecessary dependencies
- duplicated logic
- coupling
- cognitive complexity

Use automated metrics as indicators, not as goals.