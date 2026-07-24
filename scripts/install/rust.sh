#!/usr/bin/env bash
set -euo pipefail

if command -v rustup >/dev/null 2>&1; then
  echo "[pi-install] rustup already installed; updating"
  rustup update || true
  exit 0
fi

echo "[pi-install] Installing rustup"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# shellcheck disable=SC1090
. "$HOME/.cargo/env" || true
rustup update || true

echo "[pi-install] rust installed"
