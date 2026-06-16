---
mode: 'agent'
description: 'Security audit — OWASP Top 10 + AI security. Authorized contexts only.'
---

Perform a security audit of the selected code following NBR. sec-agent standards.

## Phase 1 — Secrets Detection
Scan for hardcoded secrets, tokens, passwords, API keys, private keys.

## Phase 2 — OWASP Top 10
- **A01** Broken Access Control: auth middleware coverage on all routes
- **A02** Cryptographic Failures: MD5/SHA1 usage, ECB mode, hardcoded keys
- **A03** Injection: string concatenation in SQL/shell/LDAP/NoSQL queries
- **A05** Security Misconfiguration: CORS wildcard, CSP headers, debug flags in prod
- **A07** Auth Failures: session management, JWT validation, password hashing
- **A09** Logging Failures: stack traces exposed to callers, credentials logged

## Phase 3 — AI Security (if AI code present)
- Prompt injection vectors (direct and indirect)
- Tool permission scope (is it least-privilege?)
- LLM output validation before execution
- PII sent to external models
- Rate limiting on AI endpoints

## Output Format
```
[CRITICAL|HIGH|MEDIUM|LOW] <category> — <location>
Issue: <what>
Impact: <blast radius>
Fix: <concrete remediation>
```

Authorization note: document scope before any offensive technique.
