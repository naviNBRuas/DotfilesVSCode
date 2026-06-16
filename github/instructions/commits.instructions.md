---
applyTo: "**"
---

## Commit Message Standards — NBR. Conventional Commits

**Format: `<type>: <short description>`**

```
feat: add JWT authentication middleware

- Implement token validation with expiry, issuer, and audience checks
- Add constant-time comparison to prevent timing attacks
- Wire rate limiting to all auth endpoints
- Closes #42
```

### Types
| Type | Use |
|------|-----|
| `feat` | New feature or capability |
| `fix` | Bug fix |
| `sec` | Security fix (expedited review) |
| `refactor` | Code change that doesn't add features or fix bugs |
| `perf` | Performance improvement |
| `test` | Adding or fixing tests |
| `ci` | CI/CD pipeline changes |
| `ops` | Infrastructure or deployment changes |
| `docs` | Documentation only |
| `chore` | Dependency bumps, tooling, config |
| `revert` | Reverts a previous commit |

### Rules
- First line: `<type>: <description>` — ≤ 72 chars, lowercase description
- Body: bullet points — one per logical change, explaining WHAT and WHY
- Reference ticket when available: `- Closes #123`
- Never include secrets, credentials, or binary file paths

Output: commit message only — no preamble, no explanation.
