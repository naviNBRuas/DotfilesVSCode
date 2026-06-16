---
applyTo: "**/auth/**,**/security/**,**/crypto/**,**/*auth*,**/*token*,**/*secret*,**/*password*,**/*cred*,**/*jwt*,**/*session*"
---

## Security-Critical Code Standards

- NEVER hardcode secrets, tokens, passwords, or API keys — use env vars or vault
- Validate ALL external input before processing; reject malformed input early
- Use parameterized queries — never string concatenation for SQL/LDAP/shell
- Hash passwords: `bcrypt` (cost ≥ 12), `argon2id`, or `scrypt` — never MD5/SHA1/plain
- JWT: validate signature, expiry, issuer, audience — never trust unverified payloads
- CORS: explicit allowlist — never `*` for credentialed requests
- Rate limiting: on all authentication and sensitive endpoints
- Constant-time comparison for secrets: `crypto.timingSafeEqual()` or equivalent
- Log security events (auth attempts, failures, privilege escalations) — never log credentials
- Session tokens: `httpOnly`, `secure`, `sameSite=Strict` cookies
- TLS: enforce minimum TLS 1.2; disable SSLv3/TLS 1.0/1.1
- Document authorization context before any offensive technique
