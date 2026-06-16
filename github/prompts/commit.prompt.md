---
mode: 'ask'
description: 'Generate a conventional commit message with bullet point description.'
---

Generate a commit message for the current staged changes.

**Format:**
```
<type>: <short description>

- <bullet: what changed and why>
- <bullet: what changed and why>
- Closes #<issue> (if applicable)
```

**Types:** `feat` | `fix` | `sec` | `refactor` | `perf` | `test` | `ci` | `ops` | `docs` | `chore` | `revert`

**Rules:**
- First line: `<type>: <description>` — ≤ 72 chars, lowercase description
- Body: one bullet per logical change — explain WHAT changed and WHY
- `sec:` prefix for security fixes (flags for expedited review)
- Never include secrets, credentials, or binary file references

Output: the commit message only. No preamble, no explanation.
