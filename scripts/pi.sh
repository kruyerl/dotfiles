#!/usr/bin/env bash
# scripts/pi.sh - set up Pi from this dotfiles repository
# Usage: ./scripts/pi.sh [--install] [--install-deps] [--help]

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_PI="$REPO_ROOT/configs/pi"
PI_DEST="$HOME/.pi/agent"
# shellcheck disable=SC1091
source "$REPO_ROOT/scripts/lib/node.sh"

DO_INSTALL=0
DO_INSTALL_DEPS=0

print_usage() {
  cat <<EOF
Usage: $0 [options]
Options:
  --install          Run ./scripts/npm to install pi (and other npm tools)
  --install-deps     Install npm deps for configs/pi and extensions (uses --ignore-scripts)
  --help             Show this help

This script creates (or updates) a symlink at ~/.pi/agent -> $CONFIG_PI.

Run this from the repo (script handles locating the repo root).

Note about installing deps: install-deps will run "npm install --omit=dev --ignore-scripts"
in configs/pi and any extension subfolders that have a package.json. This avoids running
project "prepare" scripts that may require developer tooling.
EOF
}

while [[ ${#@} -gt 0 ]]; do
  case "$1" in
    --install) DO_INSTALL=1; shift ;;
    --install-deps) DO_INSTALL_DEPS=1; shift ;;
    --help) print_usage; exit 0 ;;
    *) echo "Unknown arg: $1"; print_usage; exit 1 ;;
  esac
done

if [ ! -d "$CONFIG_PI" ]; then
  echo "Error: expected $CONFIG_PI to exist. Create configs/pi/ with pi files first." >&2
  exit 1
fi

mkdir -p "$HOME/.pi"
ln -sfn "$CONFIG_PI" "$PI_DEST"

echo "Created/updated symlink: $PI_DEST -> $CONFIG_PI"

if [ "$DO_INSTALL" -eq 1 ]; then
  ensure_node_runtime

  if [ -x "$REPO_ROOT/scripts/npm" ] || [ -f "$REPO_ROOT/scripts/npm" ]; then
    echo "Running $REPO_ROOT/scripts/npm"
    bash "$REPO_ROOT/scripts/npm"
    echo "Finished npm helper"
  else
    echo "No scripts/npm helper found; skipping install" >&2
  fi
fi

if [ "$DO_INSTALL_DEPS" -eq 1 ]; then
  ensure_node_runtime

  echo "Installing npm deps in $CONFIG_PI (ignore scripts)"
  (cd "$CONFIG_PI" && npm install --omit=dev --ignore-scripts)

  for ext in "$CONFIG_PI"/extensions/*; do
    if [ -f "$ext/package.json" ]; then
      echo "Installing deps for extension: $(basename "$ext")"
      (cd "$ext" && npm install --omit=dev --ignore-scripts) || true
    fi
  done

  echo "Dependency installs complete. If you need development builds or to run prepare scripts,"
  echo "re-run installs without --ignore-scripts or follow extension-specific instructions in SETUP.md."
fi

echo "Done. Start pi with: pi"
