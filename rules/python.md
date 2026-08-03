---
paths:
  - "**/*.py"
---

# Python-Specific Rules

- Use type hints on all function signatures.
- Use `pathlib.Path` for file paths, not `os.path` or string concatenation.
- Use `subprocess.run` with `check=True`, not `os.system`.
- Use `dataclasses` or `pydantic` for data containers, not raw dicts.
- Use context managers (`with`) for all resource handling.
- Use `logging` module, never `print()` for application output.
- Follow PEP 8. Line length ≤ 88 (Black default).
- Use `uv` for package management, not `pip` directly.
