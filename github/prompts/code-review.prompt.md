---
mode: 'agent'
description: 'Deep code review — NBR. review-agent standards. High-confidence findings only.'
---

Review the selected code following NBR. Company review-agent standards.

Report only HIGH confidence findings. For each:
```
[CRITICAL|HIGH|MEDIUM|LOW] Category — file:line
Issue: <concise description>
Impact: <what breaks or is at risk>
Fix: <concrete recommendation>
```

Categories: `Bug` | `Security` | `Architecture` | `Performance` | `Style`

**Quality gates — flag immediately if violated:**
- OWASP Top 10 violation
- Hardcoded secret or credential
- SQL/shell/LDAP injection via string concatenation
- Missing input validation at system boundary
- Untested critical path in security-sensitive code
- Premature abstraction or over-engineering for the stated task

Suppress low-signal style nitpicks. No summaries at the end.
