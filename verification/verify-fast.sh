#!/usr/bin/env bash
set -euo pipefail

printf 'Zentari FAST verification\n'

if [[ -f package.json ]]; then
  if command -v pnpm >/dev/null 2>&1; then PM=pnpm; elif command -v npm >/dev/null 2>&1; then PM=npm; else echo 'No Node package manager found'; exit 1; fi
  for script in format:check lint typecheck test:unit; do
    if node -e "const p=require('./package.json'); process.exit(p.scripts?.['$script']?0:1)"; then
      echo "==> $PM run $script"
      "$PM" run "$script"
    fi
  done
fi

if [[ -f pyproject.toml ]]; then
  command -v uv >/dev/null 2>&1 || { echo 'uv required for Python project'; exit 1; }
  uv run ruff check .
  if grep -q '\[tool.pytest' pyproject.toml 2>/dev/null || [[ -d tests ]]; then uv run pytest -q; fi
fi

echo 'FAST verification complete.'
