#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SOURCE="$ROOT/.agents/skills"
SKILLS_TARGET="$HOME/.agents/skills"

echo "Zentari Mac Dev Workstation bootstrap"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "ERROR: This bootstrap targets macOS." >&2
  exit 1
fi

if [[ "$(uname -m)" != "arm64" ]]; then
  echo "WARNING: This workstation is optimized for Apple Silicon."
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required. Install it from brew.sh, then rerun this script."
  exit 1
fi

brew bundle --file "$ROOT/Brewfile"

mkdir -p "$SKILLS_TARGET"
if [[ -d "$SKILLS_SOURCE" ]]; then
  for skill in "$SKILLS_SOURCE"/*; do
    [[ -d "$skill" ]] || continue
    name="$(basename "$skill")"
    if [[ -e "$SKILLS_TARGET/$name" ]]; then
      echo "SKIP skill $name: target already exists"
    else
      ln -s "$skill" "$SKILLS_TARGET/$name"
      echo "LINK skill $name"
    fi
  done
fi

echo
echo "Bootstrap complete. Run ./verification/doctor.sh next."
echo "Existing application configurations were not overwritten."
