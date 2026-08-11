#!/usr/bin/env bash
set -euo pipefail

LMSTUDIO_URL="${LMSTUDIO_URL:-http://localhost:1234/v1}"
fail=0

check() {
  local name="$1"; shift
  printf '%-34s' "$name"
  if "$@" >/dev/null 2>&1; then echo 'PASS'; else echo 'FAIL'; fail=1; fi
}

printf 'Zentari M1 Local AI Coding Loop validation\n\n'
check 'Apple Silicon' test "$(uname -m)" = arm64
check 'OpenCode installed' command -v opencode
check 'Docker/OrbStack CLI' command -v docker
check 'Docker engine reachable' docker info
check 'Node available' command -v node
check 'npx available' command -v npx
check 'Git available' command -v git
check 'LM Studio API reachable' curl -fsS "$LMSTUDIO_URL/models"
check 'Playwright MCP package' npx -y @playwright/mcp@latest --help

printf '\nMemory snapshot:\n'
vm_stat | head -8 || true
printf '\nLM Studio models:\n'
curl -fsS "$LMSTUDIO_URL/models" 2>/dev/null | python3 -m json.tool 2>/dev/null || true

if (( fail )); then
  echo '\nM1 validation has failures. Fix FAIL items before marking M1 validated.'
  exit 1
fi

echo '\nM1 base integration checks passed.'
