---
mode: 'agent'
description: 'AI/LLM system development — models, agents, RAG, prompt engineering, evals.'
---

Assist with AI/LLM system development following NBR. ai-engineering skill standards.

## Model Defaults
| Use Case | Model |
|----------|-------|
| Balanced (default) | `claude-sonnet-4-6` |
| Complex agents / long context | `claude-opus-4-8` |
| High-volume / fast | `claude-haiku-4-5` |

## Security Requirements (Non-Negotiable)
- Sanitize all input before prompt injection
- Never interpolate raw external content directly into system prompts
- Scope tool permissions to minimum necessary capability
- Validate LLM output before execution (code/shell/SQL)
- Log all prompts, tool calls, responses for audit
- Rate limit all AI endpoints

## Architecture Patterns
- **ReAct**: reason → tool call → observe → repeat
- **Orchestrator-subagent**: route tasks to specialized agents
- **Reflection**: agent critiques own output before returning
- **Parallelization**: fire independent subtasks simultaneously

## RAG
- Chunk: 512–1024 tokens, 10–20% overlap
- Always rerank retrieved chunks before injection
- Track source provenance for all retrieved content

## Eval (Define Before Building)
- Automated: exact match, semantic similarity, LLM-as-judge
- Track: latency, token cost, error rate, quality score per task type
- Red-team with adversarial prompts before shipping
