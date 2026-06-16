#!/usr/bin/env bash
# Guard against Copilot-suggested writes to sensitive files.
# Mirror of ~/.claude/bin/guard-sensitive-files.sh for VS Code context.

SENSITIVE_PATTERNS=(
    ".env"
    ".env.local"
    ".env.production"
    "*.pem"
    "*.key"
    "*.p12"
    "*.pfx"
    "id_rsa"
    "id_ed25519"
    ".aws/credentials"
    ".ssh/id_*"
    "secrets.json"
    "credentials.json"
    ".netrc"
)

TARGET="${1:-}"

if [[ -z "$TARGET" ]]; then
    exit 0
fi

for pattern in "${SENSITIVE_PATTERNS[@]}"; do
    if [[ "$TARGET" == *"$pattern"* ]] || [[ "$(basename "$TARGET")" == $pattern ]]; then
        echo "BLOCKED: Attempted write to sensitive file: $TARGET" >&2
        echo "Review this file manually before modifying." >&2
        exit 1
    fi
done

exit 0
