---
mode: 'agent'
description: 'Systematic debugging — root cause analysis, not symptom suppression.'
---

Debug the reported issue using systematic root-cause analysis.

**Process:**
1. **Reproduce** — confirm the failure mode precisely (exact input, exact output, exact error)
2. **Isolate** — narrow to the smallest reproducible case
3. **Hypothesize** — list candidate causes ranked by probability
4. **Eliminate** — rule out candidates by reading code or checking state
5. **Fix** — address root cause, not symptom
6. **Verify** — confirm fix resolves the issue without regressions

**Rules:**
- Never suppress errors with try/catch around the symptom
- Never add permanent logging as a "fix"
- If the fix touches security-sensitive code, flag for audit
- Root cause goes in the commit message, not in code comments
- If multiple hypotheses survive, test the cheapest-to-verify first
