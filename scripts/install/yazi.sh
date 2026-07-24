#!/usr/bin/env bash
set -euo pipefail

if command -v yazi-fm >/dev/null 2>&1 || command -v yazi-cli >/dev/null 2>&1; then
  echo "[pi-install] yazi already installed; skipping"
  exit 0
fi

echo "[pi-install] Installing yazi via cargo"
if command -v cargo >/dev/null 2>&1; then
  cargo install --locked --git https://github.com/sxyazi/yazi.git yazi-fm yazi-cli || true
else
  echo "cargo not found; skipping yazi install"
fi

echo "[pi-install] yazi step done"
