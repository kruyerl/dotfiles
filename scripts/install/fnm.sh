#!/usr/bin/env bash
set -euo pipefail

if command -v fnm >/dev/null 2>&1; then
  echo "[pi-install] fnm already installed; skipping"
  exit 0
fi

echo "[pi-install] Installing Fast Node Manager (fnm)"
curl -fsSL https://fnm.vercel.app/install | bash --skip-shell || true

echo "[pi-install] fnm install done"
