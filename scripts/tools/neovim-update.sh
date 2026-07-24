#!/usr/bin/env bash
set -euo pipefail

# Wrapper to update/switch Neovim version. Uses bob if available; otherwise
# falls back to the local bob-style installer (downloads to ~/.local/share/bob/nvim-bin).
# Usage: ./scripts/tools/neovim-update.sh [version]
# Example: ./scripts/tools/neovim-update.sh nightly

VERSION="${1:-${NEOVIM_VERSION:-nightly}}"

BOB_BIN="$HOME/.local/share/bob/bin/bob"

if command -v bob >/dev/null 2>&1 || [ -x "$BOB_BIN" ]; then
  BOB_EXEC="$(command -v bob || echo $BOB_BIN)"
  echo "Using bob at $BOB_EXEC to install/switch $VERSION"
  # Try common bob commands; try 'install' then 'use' then 'switch'
  if "$BOB_EXEC" install "$VERSION" 2>/dev/null; then
    echo "bob install succeeded"
  elif "$BOB_EXEC" use "$VERSION" 2>/dev/null; then
    echo "bob use succeeded"
  elif "$BOB_EXEC" switch "$VERSION" 2>/dev/null; then
    echo "bob switch succeeded"
  else
    echo "bob is present but none of install/use/switch worked (unknown interface)."
    echo "You can try running: $BOB_EXEC --help"
    exit 1
  fi
else
  echo "bob not found; falling back to direct installer"
  NEOVIM_VERSION="$VERSION" bash "$(cd "$(dirname "${BASH_SOURCE[0]}")/../install" && pwd)/neovim.sh"
fi

echo "Done"
