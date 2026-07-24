#!/usr/bin/env bash
set -euo pipefail

if command -v zoxide >/dev/null 2>&1; then
  echo "[pi-install] zoxide already installed; skipping"
  exit 0
fi

echo "[pi-install] Installing zoxide"
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh || true

echo "[pi-install] zoxide done"
