# DotfilesVSCode

**NBR. Company — VS Code + GitHub Copilot configuration.**
Supercharged Copilot setup with global instructions, 8 reusable chat prompts, 5 agent definitions, 9 shared skills, MCP server wiring, and a one-command install.

---

## What's Inside

```
DotfilesVSCode/
│
├── github/                              # Maps to ~/.github/
│   ├── copilot-instructions.md          # Global Copilot persona and standards
│   ├── instructions/                    # Auto-applied context instructions
│   │   ├── default.instructions.md      # Applied to all files — NBR. code standards
│   │   ├── code-review.instructions.md  # Applied to all — review format and gates
│   │   ├── commits.instructions.md      # Applied to all — conventional commit format
│   │   ├── testing.instructions.md      # Applied to all — test generation standards
│   │   ├── ai-systems.instructions.md   # Applied to ai/**,agents/**,llm/** etc.
│   │   ├── security.instructions.md     # Applied to auth/**,crypto/**,token/** etc.
│   │   ├── python.instructions.md       # Applied to **/*.py
│   │   └── typescript.instructions.md   # Applied to **/*.ts,**/*.tsx
│   └── prompts/                         # Copilot Chat slash commands
│       ├── feature-dev.prompt.md        # /feature-dev — implement a feature
│       ├── code-review.prompt.md        # /code-review — deep review
│       ├── security-audit.prompt.md     # /security-audit — OWASP + AI security
│       ├── debug.prompt.md              # /debug — root-cause analysis
│       ├── refactor.prompt.md           # /refactor — clean and simplify
│       ├── ops.prompt.md                # /ops — infra and DevOps
│       ├── ai-engineering.prompt.md     # /ai-engineering — LLM system work
│       └── commit.prompt.md             # /commit — generate commit message
│
├── copilot/                             # Maps to ~/.copilot/
│   ├── agents/                          # Agent role definitions
│   │   ├── orchestrator.md              # Task router and workflow coordinator
│   │   ├── dev-agent.md                 # Code, AI systems, debugging
│   │   ├── sec-agent.md                 # Security, OWASP, red-team
│   │   ├── ops-agent.md                 # CI/CD, infra, IaC
│   │   └── review-agent.md              # Quality gate and PR review
│   ├── skills/                          # Shared skill documents
│   │   ├── ai-engineering.md
│   │   ├── ai-security.md
│   │   ├── code-analysis.md
│   │   ├── cicd-pipeline.md
│   │   ├── dependency-mgmt.md
│   │   ├── deployment-automation.md
│   │   ├── git-ops.md
│   │   ├── logging-observability.md
│   │   └── vulnerability-scan.md
│   ├── hooks/
│   │   └── guard-sensitive.sh           # Blocks writes to .env, keys, credentials
│   ├── mcp/
│   │   └── registry.yaml                # MCP server catalog
│   └── setup.sh                         # Idempotent setup + workspace linker
│
└── vscode/                              # Maps to ~/.config/Code/User/ and ~/.vscode/
    ├── settings.json                    # VS Code settings (API keys scrubbed)
    ├── mcp.json                         # MCP server wiring for VS Code
    └── argv.json                        # VS Code startup arguments
```

---

## Instructions System

Instructions files in `github/instructions/` are injected into every Copilot interaction automatically, scoped by file glob.

| File | `applyTo` | Effect |
|------|-----------|--------|
| `default.instructions.md` | `**` | NBR. code standards on every response |
| `code-review.instructions.md` | `**` | High-confidence-only review format |
| `commits.instructions.md` | `**` | Conventional commit output |
| `testing.instructions.md` | `**` | Test generation standards |
| `ai-systems.instructions.md` | `**/ai/**`, `**/*agent*`, etc. | AI-specific security and patterns |
| `security.instructions.md` | `**/auth/**`, `**/*token*`, etc. | Security-critical code standards |
| `python.instructions.md` | `**/*.py` | Python standards |
| `typescript.instructions.md` | `**/*.ts`, `**/*.tsx` | TypeScript strict-mode standards |

---

## Chat Prompts

Prompts live in `github/prompts/` and appear as slash commands in Copilot Chat (VS Code 1.99+).

| Prompt | Mode | Purpose |
|--------|------|---------|
| `/feature-dev` | agent | Explore codebase, then implement with security-first discipline |
| `/code-review` | agent | Deep review — high-confidence findings only |
| `/security-audit` | agent | OWASP Top 10 + AI security. Authorized contexts only |
| `/debug` | agent | Root-cause analysis, not symptom suppression |
| `/refactor` | agent | Simplify and clarify. Preserve all behavior |
| `/ops` | agent | CI/CD, containers, IaC, deployment, observability |
| `/ai-engineering` | agent | LLM integration, RAG, agents, prompt engineering |
| `/commit` | ask | Generate a conventional commit message |

To make prompts available inside a specific repo, symlink them:
```bash
~/.copilot/setup.sh link /path/to/your/repo
```

---

## MCP Servers

Wired in `vscode/mcp.json` (`~/.config/Code/User/mcp.json`):

| Server | Purpose |
|--------|---------|
| `github` | Repo ops, PRs, issues, code search via GitHub API |
| `memory` | In-session knowledge graph (entities + relations) |
| `context7` | Live library documentation lookup |
| `sequential-thinking` | Structured reasoning for complex problem decomposition |

The GitHub MCP server uses the same `~/.claude/bin/mcp-github` wrapper from [DotfilesClaude](https://github.com/naviNBRuas/DotfilesClaude) — token sourced from `gh auth` at runtime, never stored.

---

## Agent Architecture

The Copilot setup mirrors the Claude Code multi-agent architecture from DotfilesClaude:

```
orchestrator
  ├── dev-agent     — code, AI systems, debugging, refactoring
  ├── sec-agent     — security, audits, CVEs, red-team (authorized)
  ├── ops-agent     — CI/CD, infra, containers, IaC
  └── review-agent  — quality gate, architecture validation
```

All agents share the same 9 skill documents — consistent behavior across both Claude Code and Copilot.

---

## Install

```bash
git clone https://github.com/naviNBRuas/DotfilesVSCode.git
cd DotfilesVSCode
chmod +x install.sh
./install.sh
```

The script:
1. Checks for `code`, `gh`, `node`, `npx`, and MCP server binaries
2. Creates `~/.github/`, `~/.copilot/`, and VS Code config directories
3. Installs all files with timestamped backups of any existing files
4. Skips `settings.json` and `mcp.json` if they already exist (merge manually)
5. Patches the `mcp-github` path in `mcp.json` to match your `$HOME`
6. Sets executable permissions on hook and setup scripts

### Wire prompts to a specific repo

```bash
~/.copilot/setup.sh link /path/to/your/repo
# Creates symlinks in /path/to/your/repo/.github/prompts/ and .github/instructions/
```

### MCP server dependencies

```bash
npm install -g @modelcontextprotocol/server-github
npm install -g @modelcontextprotocol/server-memory
```

---

## VS Code Settings

`vscode/settings.json` contains the full VS Code config with:
- Copilot enabled globally, disabled for `quarto`
- All Copilot Chat features enabled (thinking, web search, NES, memory tool)
- Instruction files wired to each Copilot chat mode
- MCP autostart on request
- Claude Code panel location set to `panel`
- LaTeX, R Markdown, and Playwright configs

> **Note:** Any API keys or personal identifiers from the original `settings.json` have been scrubbed. Adjust `geminicodeassist.project`, `google.cloud.project`, and other personal fields after install.

---

## Requirements

- **VS Code** 1.99+ (for prompt files and MCP support)
- **GitHub Copilot** subscription
- **GitHub CLI** (`gh`) — for the GitHub MCP wrapper
- **Node.js** 18+ — for MCP servers
- **[DotfilesClaude](https://github.com/naviNBRuas/DotfilesClaude)** — optional but recommended; shares the MCP GitHub wrapper and skills

---

## Related

- [DotfilesClaude](https://github.com/naviNBRuas/DotfilesClaude) — Claude Code configuration (agents, skills, MCP, status line)

---

## License

MIT — [Navin B. Ruas](https://github.com/naviNBRuas)
