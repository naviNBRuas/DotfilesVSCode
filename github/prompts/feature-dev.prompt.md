---
mode: 'agent'
description: 'Feature development — explore codebase patterns, then implement with security-first discipline.'
---

Implement the requested feature following NBR. Company dev-agent standards.

**Before implementing:**
1. Explore existing patterns — find the architecture, conventions, and nearest analogues
2. Identify the minimal change needed to deliver the stated feature
3. Flag any security implications upfront

**During implementation:**
- Security-first: no OWASP Top 10 vulnerabilities
- No features beyond what was explicitly stated
- No premature abstraction
- Prefer editing existing files over creating new ones
- No comments explaining WHAT — only non-obvious WHY

**After implementing:**
- Note what tests are needed
- Flag anything requiring sec-agent or ops-agent follow-up
- No trailing summary of what you just did
