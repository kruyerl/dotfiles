#!/usr/bin/env bash
set -euo pipefail

NVIM_PATH="/usr/local/bin/nvim"
if [ -x "$NVIM_PATH" ]; then
  echo "[pi-install] neovim already installed at $NVIM_PATH"
  exit 0
fi

echo "[pi-install] Installing neovim appimage"
TMP="$(mktemp -d)"
cd "$TMP"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage "$NVIM_PATH"
cd - >/dev/null || true
rm -rf "$TMP"

echo "[pi-install] neovim installed to $NVIM_PATH"
