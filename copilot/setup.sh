#!/usr/bin/env bash
# NBR. Company — GitHub Copilot Supercharged Setup
# Run once to wire everything together. Idempotent.

set -euo pipefail

COPILOT_DIR="$HOME/.copilot"
GITHUB_DIR="$HOME/.github"
VSCODE_USER_DIR="$HOME/.config/Code/User"

echo "=== NBR. Copilot Setup ==="

# ── 1. Verify dependencies ────────────────────────────────────────────────────
check_cmd() {
    command -v "$1" &>/dev/null || echo "  [WARN] $1 not found — $2"
}

echo ""
echo "Checking dependencies..."
check_cmd "code" "VS Code CLI not in PATH"
check_cmd "gh" "GitHub CLI required for GitHub MCP server"
check_cmd "npx" "Node.js required for context7 + sequential-thinking MCP servers"
check_cmd "mcp-server-memory" "Install: npm install -g @modelcontextprotocol/server-memory"

# ── 2. Ensure directories exist ───────────────────────────────────────────────
echo ""
echo "Ensuring directories..."
mkdir -p "$GITHUB_DIR/prompts" "$GITHUB_DIR/instructions"
mkdir -p "$COPILOT_DIR/agents" "$COPILOT_DIR/skills" "$COPILOT_DIR/mcp" "$COPILOT_DIR/hooks"
mkdir -p "$VSCODE_USER_DIR"
echo "  OK"

# ── 3. Make hooks executable ──────────────────────────────────────────────────
echo ""
echo "Setting hook permissions..."
chmod +x "$COPILOT_DIR/hooks/"*.sh 2>/dev/null || true
echo "  OK"

# ── 4. Link prompts into a workspace (usage: ./setup.sh link /path/to/repo) ──
link_to_workspace() {
    local WORKSPACE="$1"
    if [[ ! -d "$WORKSPACE" ]]; then
        echo "  [ERROR] Workspace not found: $WORKSPACE"
        return 1
    fi

    local TARGET="$WORKSPACE/.github"
    mkdir -p "$TARGET/prompts" "$TARGET/instructions"

    # Symlink prompt files
    for f in "$GITHUB_DIR/prompts/"*.prompt.md; do
        local name
        name="$(basename "$f")"
        if [[ ! -L "$TARGET/prompts/$name" ]]; then
            ln -s "$f" "$TARGET/prompts/$name"
            echo "  linked: $TARGET/prompts/$name"
        fi
    done

    # Symlink instruction files (except default — VS Code injects that globally)
    for f in "$GITHUB_DIR/instructions/"*.instructions.md; do
        local name
        name="$(basename "$f")"
        if [[ "$name" != "default.instructions.md" ]] && [[ ! -L "$TARGET/instructions/$name" ]]; then
            ln -s "$f" "$TARGET/instructions/$name"
            echo "  linked: $TARGET/instructions/$name"
        fi
    done

    echo "  Prompts and instructions linked to $WORKSPACE"
}

if [[ "${1:-}" == "link" ]] && [[ -n "${2:-}" ]]; then
    echo ""
    echo "Linking to workspace: $2"
    link_to_workspace "$2"
    echo ""
    echo "Done. Restart VS Code for prompt files to appear in Copilot Chat."
    exit 0
fi

# ── 5. Verify VS Code MCP config ─────────────────────────────────────────────
echo ""
echo "VS Code MCP config: $VSCODE_USER_DIR/mcp.json"
if [[ -f "$VSCODE_USER_DIR/mcp.json" ]]; then
    echo "  OK (exists)"
else
    echo "  [WARN] mcp.json not found — run this script from the copilot session"
fi

# ── 6. Summary ───────────────────────────────────────────────────────────────
echo ""
echo "=== Setup Complete ==="
echo ""
echo "Global instructions: $GITHUB_DIR/instructions/"
echo "Copilot prompts:     $GITHUB_DIR/prompts/ (symlink to workspaces with: ./setup.sh link /path/to/repo)"
echo "Agent definitions:   $COPILOT_DIR/agents/"
echo "Skill templates:     $COPILOT_DIR/skills/"
echo "MCP registry:        $COPILOT_DIR/mcp/registry.yaml"
echo "VS Code MCP:         $VSCODE_USER_DIR/mcp.json"
echo ""
echo "Restart VS Code to activate all changes."
