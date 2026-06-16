---
applyTo: "**/ai/**,**/llm/**,**/agents/**,**/rag/**,**/*agent*,**/*llm*,**/*embedding*,**/*prompt*,**/*anthropic*,**/*openai*"
---

## AI System Standards

### Model Selection
- Default: `claude-sonnet-4-6` (balanced performance/cost)
- Complex reasoning / long context: `claude-opus-4-8`
- High-volume / fast: `claude-haiku-4-5`
- Verify model IDs before hardcoding — they change

### Security (Non-Negotiable)
- Treat all user input as untrusted — sanitize before injecting into prompts
- Never interpolate raw external/retrieved content directly into system prompts
- Scope all tool permissions to minimum necessary capability
- Validate LLM output before execution (especially code/shell/SQL)
- Log all prompts, tool calls, and responses for audit
- Rate limit all AI endpoints

### Prompt Engineering
- System prompt: role + constraints + output format — not task instructions
- User turn: the actual task — keep it focused
- Temperature: 0 for deterministic/factual, 0.7–1.0 for creative
- Few-shot examples outperform long instruction lists for format enforcement

### RAG
- Chunk: 512–1024 tokens, 10–20% overlap
- Always rerank retrieved chunks before injecting
- Track source provenance for all retrieved content
- Evaluate retrieval recall separately from generation quality

### Agent Patterns
- ReAct: reason → tool call → observe → repeat
- Orchestrator-subagent: route tasks to specialized agents
- Reflection: agent critiques own output before returning
- Parallelization: independent subtasks dispatched simultaneously
