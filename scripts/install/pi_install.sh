#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
NPM_HELPER="$REPO_ROOT/scripts/npm"

if [ -f "$NPM_HELPER" ]; then
  echo "[pi-install] Running npm helper to install pi and global npm tools"
  bash "$NPM_HELPER" || true
else
  echo "[pi-install] npm helper not found at $NPM_HELPER; skipping"
fi

echo "[pi-install] pi install step done"
