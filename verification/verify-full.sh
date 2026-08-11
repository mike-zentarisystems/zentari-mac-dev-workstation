#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
"$ROOT/verification/verify-fast.sh"

if [[ -f package.json ]]; then
  PM=$(command -v pnpm >/dev/null 2>&1 && echo pnpm || echo npm)
  for script in test test:integration build test:e2e; do
    if node -e "const p=require('./package.json'); process.exit(p.scripts?.['$script']?0:1)"; then "$PM" run "$script"; fi
  done
fi

command -v gitleaks >/dev/null 2>&1 && gitleaks detect --source . --no-banner
command -v semgrep >/dev/null 2>&1 && semgrep scan --config auto .

echo 'FULL verification complete.'
