#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
"$ROOT/verification/verify-full.sh"

command -v osv-scanner >/dev/null 2>&1 || { echo 'osv-scanner required for RELEASE'; exit 1; }
osv-scanner scan source -r .

if [[ -f Dockerfile ]]; then
  command -v docker >/dev/null 2>&1 || { echo 'Docker/OrbStack required'; exit 1; }
  command -v trivy >/dev/null 2>&1 || { echo 'Trivy required'; exit 1; }
  IMAGE="zentari-verify:$(git rev-parse --short HEAD 2>/dev/null || echo local)"
  docker build -t "$IMAGE" .
  trivy image --exit-code 1 --severity HIGH,CRITICAL "$IMAGE"
fi

echo 'RELEASE verification complete.'
