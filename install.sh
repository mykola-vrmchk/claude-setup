#!/usr/bin/env bash
# Installs the output styles into ~/.claude and makes Architect the default.
# From a clone it symlinks, so edits apply at once; piped from curl (cloud) it downloads.
set -euo pipefail

RAW_URL="https://raw.githubusercontent.com/mykola-vrmchk/claude-setup/main"
STYLES=(architect.md)
CONFIG_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

# Empty when piped, so a piped run never mistakes the current directory for a clone.
REPO_DIR=""
if [ -f "${BASH_SOURCE[0]:-}" ]; then
  REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

mkdir -p "$CONFIG_DIR/output-styles"
for style in "${STYLES[@]}"; do
  target="$CONFIG_DIR/output-styles/$style"
  if [ -n "$REPO_DIR" ] && [ -f "$REPO_DIR/output-styles/$style" ]; then
    ln -sfn "$REPO_DIR/output-styles/$style" "$target"
  else
    curl -fsSL "$RAW_URL/output-styles/$style" -o "$target"
  fi
done

python3 - "$CONFIG_DIR/settings.json" <<'PY'
import json, os, sys
path = sys.argv[1]
settings = json.load(open(path)) if os.path.exists(path) else {}
settings["outputStyle"] = "Architect"
with open(path, "w") as handle:
    json.dump(settings, handle, indent=2)
PY

echo "claude-setup: installed ${STYLES[*]} into $CONFIG_DIR, outputStyle=Architect"
