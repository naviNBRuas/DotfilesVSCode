---
applyTo: "**"
---

## Test Generation Standards — NBR. Company

### Structure
- Test description: behavior being tested, not implementation detail
- Arrange → Act → Assert pattern, clearly delineated
- One assertion per test when practical; group related assertions
- Use real data fixtures over mocks at system boundaries when possible

### Coverage Priority
1. Happy path (core behavior)
2. Security boundary (auth, input validation, injection vectors)
3. Error conditions (network failures, invalid input, not-found)
4. Edge cases with realistic data

### Never
- Mock the database just to make tests faster (masks real failures)
- Test implementation details — test behavior and contracts
- Leave `TODO` or `skip` without a concrete reason and date

### Naming
- `it('returns 401 when token is expired')` — behavior-first
- Not `it('works')` or `it('test 1')`
