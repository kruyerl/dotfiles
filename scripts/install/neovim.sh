#!/usr/bin/env bash
set -euo pipefail

# Install Neovim into bob's expected directory (~/.local/share/bob/nvim-bin)
# Fallback: if nvim exists on PATH, skip. Otherwise download latest neovim-linux64
# release and copy the nvim binary into the bob directory.

INSTALL_DIR="$HOME/.local/share/bob/nvim-bin"
mkdir -p "$INSTALL_DIR"

# If nvim is already available in PATH, skip installation
if command -v nvim >/dev/null 2>&1; then
  echo "[pi-install] nvim already available in PATH: $(command -v nvim)" && exit 0
fi

echo "[pi-install] Installing Neovim into $INSTALL_DIR"
TMPDIR="$(mktemp -d)"
ARCHIVE="$TMPDIR/nvim.tar.gz"

# Use the official GitHub "nvim-linux64" archive (works on x86_64 Linux)
URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz"

echo "[pi-install] Downloading: $URL"
if ! curl -fSL "$URL" -o "$ARCHIVE"; then
  echo "[pi-install] Failed to download Neovim archive; falling back to appimage"
  curl -fSL "https://github.com/neovim/neovim/releases/latest/download/nvim.appimage" -o "$TMPDIR/nvim.appimage"
  chmod +x "$TMPDIR/nvim.appimage"
  mv "$TMPDIR/nvim.appimage" "$INSTALL_DIR/nvim"
  chmod +x "$INSTALL_DIR/nvim"
  echo "[pi-install] Installed appimage as $INSTALL_DIR/nvim"
  rm -rf "$TMPDIR"
  exit 0
fi

mkdir -p "$TMPDIR/extract"
 tar -xzf "$ARCHIVE" -C "$TMPDIR/extract"

# The archive usually contains a directory like nvim-linux64/bin/nvim
BIN_PATH="$(find "$TMPDIR/extract" -type f -path '*/bin/nvim' -print -quit)"
if [ -z "$BIN_PATH" ]; then
  echo "[pi-install] Couldn't find nvim binary in archive; aborting"
  rm -rf "$TMPDIR"
  exit 1
fi

cp "$BIN_PATH" "$INSTALL_DIR/nvim"
chmod +x "$INSTALL_DIR/nvim"

rm -rf "$TMPDIR"

echo "[pi-install] Neovim installed to $INSTALL_DIR/nvim"

echo "Note: your shell config should include $HOME/.local/share/bob/nvim-bin in PATH (configs/zshrc already does this)"
