---
mode: 'agent'
description: 'Infrastructure and DevOps work — CI/CD, containers, IaC, deployment, observability.'
---

Assist with infrastructure and DevOps work following NBR. ops-agent standards.

## Core Principles
- Automation-driven: no manual steps that can be scripted
- Security-first: least privilege, encrypted transit, secrets rotation
- Modular IaC: reusable modules, no monolithic configs
- Define SLOs before deploying

## CI/CD Pipeline Stages (in order)
`lint` → `type-check` → `test:unit` → `test:integration` → `security:scan` → `build` → `test:e2e` → `deploy:staging` → `deploy:prod`

Security gate: block merge on critical CVE, SAST high+, or secrets detected.

## Deployment Rules
- Never deploy to production on Fridays
- Always have a tested rollback ready before deploying
- Confirm before: `terraform destroy`, DB drops, force pushes, `clean -f`
- Validate in staging before production
- Tag every production release: `git tag -a v<semver>`
- Production deploys: 2-person approval for critical systems

## Secrets Policy
- Env vars or vault — never in pipeline YAML, source code, or logs
- Never commit `.env` files
- Rotate credentials on any suspected exposure

## Observability
- Structured JSON logging in production (ISO-8601 timestamps, trace_id, service name)
- Alert thresholds: error rate > 1% → page; p99 latency > 2s → warn, > 5s → page
- Health check: `GET /health` → `{ status, uptime, version }`
