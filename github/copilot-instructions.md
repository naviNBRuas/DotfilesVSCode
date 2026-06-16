# NBR. Company — GitHub Copilot Global Configuration

## Identity
Navin B. Ruas | @naviNBRuas | Founder, NBR. Company
Primary domains: software development · AI engineering · cybersecurity

Work at expert level. Skip basic explanations. No hand-holding.

---

## Agent System

This Copilot setup mirrors the NBR. Claude Code multi-agent architecture. Mentally route tasks to the right domain:

| Task | Domain |
|------|--------|
| Code, features, debugging, refactoring, AI system implementation | dev-agent |
| Security audits, CVEs, threat models, pen-test support, AI security | sec-agent |
| CI/CD, infra, deployment, containers, reliability, IaC | ops-agent |
| PR review, architecture validation, quality gate | review-agent |
| Multi-domain (e.g. secure AI deployment) | orchestrator → parallel dispatch |

Full agent definitions: `~/.copilot/agents/`
Full skill templates: `~/.copilot/skills/`

---

## Code Standards (Non-Negotiable)

- No OWASP Top 10 vulnerabilities — ever
- No premature abstraction; no features beyond the stated task
- No error handling for impossible/internal scenarios — only validate at system boundaries
- No comments explaining WHAT — name things clearly; comment only non-obvious WHY
- Prefer editing existing files over creating new ones
- Security-first always: secrets in env/vault, never hardcoded
- Shortest effective implementation wins

---

## AI Engineering Defaults

- Default model: `claude-sonnet-4-6` (balanced performance/cost)
- Complex agents / long context: `claude-opus-4-8`
- High-volume / fast: `claude-haiku-4-5`
- Apply ai-engineering skill patterns for any LLM/AI work
- Apply ai-security skill patterns when building or auditing AI systems

---

## Security Policy

- All offensive techniques require explicit authorization context before proceeding
- Never introduce OWASP Top 10 vulnerabilities
- Minimum viable permissions for all systems and agents
- Secrets: env vars or vault — never in source code, CI YAML, or logs
- AI systems: sanitize all input before prompt injection; validate all LLM output before execution

---

## MCP Servers (Active)

| Server | Purpose |
|--------|---------|
| `github` | Code search, PRs, issues, file ops via GitHub API |
| `memory` | Session knowledge graph (entities + relations) |
| `context7` | Library documentation lookup |

---

## Skills Available

| Skill | Purpose |
|-------|---------|
| `ai-engineering` | LLM integration, RAG, agents, prompt engineering |
| `ai-security` | Prompt injection, OWASP LLM Top 10, adversarial ML |
| `vulnerability-scan` | SAST, dependency audit, secrets detection |
| `code-analysis` | Codebase exploration before implementing |
| `git-ops` | Branching, commits, PR workflows |
| `cicd-pipeline` | GitHub Actions, pipeline design |
| `dependency-mgmt` | npm/pip/go/cargo package management |
| `deployment-automation` | Release strategies, rollback, environment promotion |
| `logging-observability` | Structured logging, metrics, alerting, tracing |

Full skill content: `~/.copilot/skills/`
