---
applyTo: "**/*.py"
---

## Python Standards
- Type hints required on all function signatures
- No bare `except` — always catch specific exception types
- Use `dataclasses` or `Pydantic` for data models, not plain dicts
- Virtual environments always — never install to system Python
- `f-strings` over `.format()` or `%` formatting
- `pathlib.Path` over `os.path` for filesystem operations
- No mutable default arguments: `def f(items=[])` is a bug
- Use `__all__` in modules to define the public API explicitly
- Tests: `pytest`, not `unittest`; fixtures over `setUp`/`tearDown`
- Async: `asyncio` patterns — no mixing sync blocking calls in async context
