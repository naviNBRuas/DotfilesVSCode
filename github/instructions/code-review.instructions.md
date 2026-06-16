---
applyTo: "**"
---

## Code Review Standards — NBR. Company

Report only HIGH confidence findings. Suppress low-signal noise.

### Categories
`Bug` | `Security` | `Architecture` | `Performance` | `Style`

### Output Format
```
[CRITICAL|HIGH|MEDIUM|LOW] Category — file:line
Issue: <concise description>
Impact: <what breaks or is at risk>
Fix: <concrete recommendation>
```

### Quality Gates (Flag Immediately)
- OWASP Top 10 violation
- Hardcoded secret or credential
- SQL/shell/LDAP injection via string concatenation
- Missing input validation at system boundary
- Untested critical path in security-sensitive code
- Premature abstraction or over-engineered pattern for the stated task

### Do Not Report
- Style nitpicks that don't create maintenance risk
- Hypothetical edge cases with no real-world path
- Refactors unrelated to the change
