#!/usr/bin/env bash
set -u

PASS=0
WARN=0
FAIL=0

check_cmd() {
  local label="$1" cmd="$2"
  if command -v "$cmd" >/dev/null 2>&1; then
    printf 'PASS  %-24s %s\n' "$label" "$(command -v "$cmd")"
    PASS=$((PASS + 1))
  else
    printf 'FAIL  %-24s missing\n' "$label"
    FAIL=$((FAIL + 1))
  fi
}

check_optional() {
  local label="$1" cmd="$2"
  if command -v "$cmd" >/dev/null 2>&1; then
    printf 'PASS  %-24s %s\n' "$label" "$(command -v "$cmd")"
    PASS=$((PASS + 1))
  else
    printf 'WARN  %-24s not detected\n' "$label"
    WARN=$((WARN + 1))
  fi
}

echo "Zentari workstation doctor"
echo

[[ "$(uname -s)" == "Darwin" ]] && echo "PASS  macOS" || echo "FAIL  macOS"
[[ "$(uname -m)" == "arm64" ]] && echo "PASS  Apple Silicon" || echo "WARN  Apple Silicon not detected"

check_cmd "Homebrew" brew
check_cmd "Git" git
check_cmd "GitHub CLI" gh
check_cmd "Node" node
check_cmd "pnpm" pnpm
check_cmd "uv" uv
check_cmd "Docker/OrbStack" docker
check_cmd "Gitleaks" gitleaks
check_cmd "Semgrep" semgrep
check_cmd "OSV-Scanner" osv-scanner
check_cmd "Trivy" trivy
check_optional "OpenCode" opencode
check_optional "Zed CLI" zed
check_optional "LM Studio CLI" lms

if curl -fsS --max-time 2 http://localhost:1234/v1/models >/dev/null 2>&1; then
  echo "PASS  LM Studio API            http://localhost:1234/v1"
  PASS=$((PASS + 1))
else
  echo "WARN  LM Studio API            not reachable on localhost:1234"
  WARN=$((WARN + 1))
fi

if docker info >/dev/null 2>&1; then
  echo "PASS  Docker engine            reachable"
  PASS=$((PASS + 1))
else
  echo "WARN  Docker engine            start OrbStack"
  WARN=$((WARN + 1))
fi

echo
echo "Result: $PASS pass, $WARN warning, $FAIL fail"
[[ "$FAIL" -eq 0 ]]
