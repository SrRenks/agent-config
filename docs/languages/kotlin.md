# Kotlin Guidelines

## Tooling

Use:
- ktlint (formatting) via the `org.jlleitschuh.gradle.ktlint` Gradle plugin (v14.x as of 2026-08; pin at scaffold time)
- detekt (static analysis / complexity) via the detekt Gradle plugin — current stable 1.x line (2.0.0 is in alpha as of 2026-06)
- Android Lint (built into AGP) for Android-specific issues
- JUnit + `kotlin.test` for unit tests, run with `./gradlew test`
- `make` / `make test` / `make lint` as thin wrappers over the Gradle equivalents

## Recommended Linter Configuration

### detekt — enforce complexity budgets

Enable these rules in the `complexity` rule set (rule names per current detekt docs; detekt 1.x used `ComplexMethod` where current docs use `CyclomaticComplexMethod`):

- `CyclomaticComplexMethod` – cyclomatic complexity (budget: 10)
- `CognitiveComplexMethod` – cognitive complexity (budget: 15)
- `LongParameterList` – parameters (budget: 4)
- `LongMethod` – function length (budget: 60)
- `NestedBlockDepth` – nesting depth (budget: 3)
- `LargeClass` – file length (budget: 500)

Example `detekt.yml`:

```yaml
complexity:
  CyclomaticComplexMethod:
    active: true
    threshold: 10
  CognitiveComplexMethod:
    active: true
    allowedComplexity: 15
  LongParameterList:
    active: true
    allowedFunctionParameters: 4
  LongMethod:
    active: true
    allowedLines: 60
  NestedBlockDepth:
    active: true
    allowedDepth: 3
  LargeClass:
    active: true
    threshold: 500
```

Note: detekt has historically reported when complexity *equals* the threshold (inclusive comparison). If the pinned version behaves this way, set the threshold to N+1 to enforce "≤ N". Verify at scaffold time.

### ktlint — formatting

- Configure `.editorconfig`: `max_line_length = 100`, `indent_size = 4` (Jetpack Compose convention), `charset = utf-8`.
- Run `./gradlew ktlintCheck` in CI and `./gradlew ktlintFormat` for autofix.

### Android Lint

- Run `./gradlew lint` — catches permission, manifest, and deprecated-API issues that detekt cannot see.

## Practices

- Kotlin is the only application language. No Java source files.
- Follow the official Android Kotlin style guide and the Kotlin coding conventions.
- Naming: PascalCase classes, camelCase functions/properties, UPPER_SNAKE_CASE for `const val` and top-level constants.
- Build: Gradle Kotlin DSL only (no Groovy). Dependency versions live in the version catalog (`gradle/libs.versions.toml`). Kotlin 2.4.x line (current stable 2.4.10, released 2026-07-14).
- UI: Jetpack Compose only — no XML layouts. The Compose compiler plugin (`org.jetbrains.kotlin.plugin.compose`) is versioned with Kotlin.
- Data layer: Room + Coroutines/Flow. Repositories expose `Flow`. No blocking calls on the main thread; use `Dispatchers.IO` for disk I/O.
- Domain/parser layer: pure Kotlin with no Android framework dependencies — unit-testable on the JVM via `./gradlew test`.
- Prefer `val` over `var`; prefer immutable data. Use `data class` for value carriers and sealed classes/interfaces for state and result hierarchies.
- Null safety: never use `!!`. Use safe calls, `?:`, or explicit checks; keep nullability explicit at API boundaries.
- Error handling: never ignore errors; add context when propagating. Prefer `Result` or sealed result types over exceptions for expected failures.
- Control flow: guard clauses and early returns; no `else` after `return`/`break`/`continue`; flatten conditionals.
- Logging: never log passwords, tokens, secrets, or private financial data.
- No speculative abstractions; no interfaces solely for mocking; constructor injection without a DI framework unless justified.
- Stay within the complexity budgets in `docs/complexity.md` (cyclomatic ≤10, cognitive ≤15, function ≤60 lines, file ≤500 lines, nesting ≤3, params ≤4).
