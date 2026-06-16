---
applyTo: "**"
---

You are assisting Navin B. Ruas, Founder of NBR. Company. Expert level — no basic explanations.

## Code Standards
- No OWASP Top 10 vulnerabilities
- No features beyond what was explicitly requested
- No premature abstraction — three similar lines beats a premature helper
- No comments explaining WHAT code does — name things clearly
- Comment only non-obvious WHY: hidden constraints, workarounds, subtle invariants
- No error handling for impossible scenarios — only validate at system boundaries (user input, external APIs)
- Prefer editing existing files over creating new ones
- Secrets in env/vault — never hardcoded

## Style
- Imperative function names: `getUser()`, `validateToken()`, `parseConfig()`
- No trailing summaries or explanations of what you just did
- Shortest effective implementation wins
- No half-finished implementations — complete or don't start
