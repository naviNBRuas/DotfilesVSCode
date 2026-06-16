#!/usr/bin/env bash
# DotfilesVSCode — Install Script
# Installs NBR. Company VS Code + GitHub Copilot configuration.
# Idempotent: safe to run multiple times.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GITHUB_DIR="$HOME/.github"
COPILOT_DIR="$HOME/.copilot"
VSCODE_USER_DIR="$HOME/.config/Code/User"

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
R='\033[0m'

info()    { echo -e "${CYAN}  →${R} $*"; }
success() { echo -e "${GREEN}  ✓${R} $*"; }
warn()    { echo -e "${YELLOW}  !${R} $*"; }
error()   { echo -e "${RED}  ✗${R} $*"; }

echo ""
echo -e "${CYAN}DotfilesVSCode — NBR. Company${R}"
echo -e "${CYAN}══════════════════════════════${R}"
echo ""

# ── 1. Preflight checks ───────────────────────────────────────────────────────
echo "Checking dependencies..."

check_cmd() {
  if command -v "$1" &>/dev/null; then
    success "$1 found"
  else
    warn "$1 not found — $2"
  fi
}

check_cmd "code"              "Install VS Code: https://code.visualstudio.com"
check_cmd "gh"                "Required for GitHub MCP server: https://cli.github.com"
check_cmd "node"              "Required for MCP servers: https://nodejs.org"
check_cmd "npx"               "Bundled with Node.js"
check_cmd "mcp-server-memory" "Install: npm install -g @modelcontextprotocol/server-memory"
check_cmd "mcp-server-github" "Install: npm install -g @modelcontextprotocol/server-github"

echo ""

# ── 2. Ensure directories exist ───────────────────────────────────────────────
echo "Creating directories..."
mkdir -p "$GITHUB_DIR/instructions" "$GITHUB_DIR/prompts"
mkdir -p "$COPILOT_DIR/agents" "$COPILOT_DIR/skills" "$COPILOT_DIR/hooks" "$COPILOT_DIR/mcp"
mkdir -p "$VSCODE_USER_DIR"
success "Directories ready"
echo ""

# ── 3. Install function ───────────────────────────────────────────────────────
install_file() {
  local src="$1"
  local dst="$2"
  if [ -f "$dst" ]; then
    cp "$dst" "${dst}.bak.$(date +%Y%m%d%H%M%S)"
  fi
  cp "$src" "$dst"
  info "$(basename "$dst")"
}

# ── 4. GitHub Copilot global instructions ────────────────────────────────────
echo "Installing GitHub Copilot global config..."
install_file "$REPO_DIR/github/copilot-instructions.md" "$GITHUB_DIR/copilot-instructions.md"

echo "Installing instruction files..."
for f in "$REPO_DIR/github/instructions/"*.md; do
  install_file "$f" "$GITHUB_DIR/instructions/$(basename "$f")"
done

echo "Installing prompt files..."
for f in "$REPO_DIR/github/prompts/"*.md; do
  install_file "$f" "$GITHUB_DIR/prompts/$(basename "$f")"
done

# ── 5. Copilot agents and skills ─────────────────────────────────────────────
echo ""
echo "Installing Copilot agents..."
for f in "$REPO_DIR/copilot/agents/"*.md; do
  install_file "$f" "$COPILOT_DIR/agents/$(basename "$f")"
done

echo "Installing Copilot skills..."
for f in "$REPO_DIR/copilot/skills/"*.md; do
  install_file "$f" "$COPILOT_DIR/skills/$(basename "$f")"
done

echo "Installing Copilot hooks..."
for f in "$REPO_DIR/copilot/hooks/"*.sh; do
  install_file "$f" "$COPILOT_DIR/hooks/$(basename "$f")"
  chmod +x "$COPILOT_DIR/hooks/$(basename "$f")"
done
success "hooks marked executable"

install_file "$REPO_DIR/copilot/mcp/registry.yaml" "$COPILOT_DIR/mcp/registry.yaml"
install_file "$REPO_DIR/copilot/setup.sh" "$COPILOT_DIR/setup.sh"
chmod +x "$COPILOT_DIR/setup.sh"

# ── 6. VS Code User config ────────────────────────────────────────────────────
echo ""
echo "Installing VS Code config..."

# settings.json: only install if absent — avoid clobbering live settings
if [ ! -f "$VSCODE_USER_DIR/settings.json" ]; then
  install_file "$REPO_DIR/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
  info "settings.json (new install)"
else
  warn "settings.json already exists — skipping (merge manually if needed)"
fi

# mcp.json: update the mcp-github path to the real location
MCP_DST="$VSCODE_USER_DIR/mcp.json"
if [ ! -f "$MCP_DST" ]; then
  sed "s|<path-to>|$HOME|g" "$REPO_DIR/vscode/mcp.json" > "$MCP_DST"
  info "mcp.json (with patched path)"
else
  warn "mcp.json already exists — skipping (merge manually if needed)"
fi

install_file "$REPO_DIR/vscode/argv.json" "$HOME/.vscode/argv.json"

# ── 7. Summary ────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}Installation complete.${R}"
echo ""
echo "  Global instructions:  $GITHUB_DIR/instructions/ (8 files)"
echo "  Copilot prompts:      $GITHUB_DIR/prompts/ (8 prompts)"
echo "  Copilot agents:       $COPILOT_DIR/agents/ (5 agents)"
echo "  Copilot skills:       $COPILOT_DIR/skills/ (9 skills)"
echo "  VS Code settings:     $VSCODE_USER_DIR/settings.json"
echo "  VS Code MCP:          $VSCODE_USER_DIR/mcp.json"
echo ""
echo "  To link prompts to a workspace:"
echo "    $COPILOT_DIR/setup.sh link /path/to/your/repo"
echo ""
echo "  Restart VS Code to activate all changes."
echo ""
