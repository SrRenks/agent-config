# Python Guidelines

## Tooling

Use:
- ruff
- pytest
- mypy when applicable

## Recommended Linter Configuration

Use `ruff` with rules that enforce complexity budgets and code smells. Enable:

- `C901` - cyclomatic complexity (max 10)
- `PLR0915` - too many statements (function length)
- `PLR0912` - too many branches
- `PLR0913` - too many arguments (max 4)
- `RUF100` - unused noqa

Example `pyproject.toml`:

```toml
[tool.ruff.lint]
select = ["C901", "PLR0915", "PLR0912", "PLR0913", "RUF100"]

[tool.ruff.lint.per-file-ignores]
"**/test_*.py" = ["PLR0915"]  # tests may be longer
```

Additionally, run radon mi to track Maintainability Index, and bandit for security


## Practices

Use type hints, `pathlib`, and standard library over third-party packages
Do not use dynamic behavior without justification. Keep classes small. Do not use unnecessary frameworks