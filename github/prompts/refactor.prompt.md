---
mode: 'agent'
description: 'Code refactoring — simplify, clarify, consolidate. Preserve all behavior.'
---

Refactor the selected code for clarity, simplicity, and maintainability.

**Hard constraints:**
- Preserve ALL existing behavior exactly — this is not a feature change
- No new dependencies
- No new abstractions unless code is duplicated 3+ times
- The public API/interface must remain unchanged

**Priority order:**
1. Eliminate dead code and unused variables
2. Reduce nesting depth (early returns, guard clauses)
3. Extract duplicated logic — only when used 3+ times
4. Clarify names — functions should describe what they do
5. Remove comments that explain WHAT (the code should do that)
6. Consolidate similar patterns

**Do not:**
- Add features ("while we're here...")
- Add error handling for impossible scenarios
- Over-engineer for hypothetical future requirements
