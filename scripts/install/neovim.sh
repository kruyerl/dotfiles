#!/usr/bin/env bash
set -euo pipefail

# Install Neovim into bob's expected directory (~/.local/share/bob/nvim-bin)
# Supports NEOVIM_VERSION env var. Defaults to 'nightly'.

NEOVIM_VERSION="${NEOVIM_VERSION:-nightly}"
INSTALL_DIR="$HOME/.local/share/bob/nvim-bin"
mkdir -p "$INSTALL_DIR"

# If nvim is already available in PATH, skip installation
if command -v nvim >/dev/null 2>&1; then
  echo "[pi-install] nvim already available in PATH: $(command -v nvim)" && exit 0
fi

echo "[pi-install] Installing Neovim ($NEOVIM_VERSION) into $INSTALL_DIR"
TMPDIR="$(mktemp -d)"
ARCHIVE="$TMPDIR/nvim.tar.gz"

case "$NEOVIM_VERSION" in
  nightly)
    URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz"
    ;;
  latest)
    URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz"
    ;;
  *)
    # assume a tag like v0.9.3
    URL="https://github.com/neovim/neovim/releases/download/${NEOVIM_VERSION}/nvim-linux64.tar.gz"
    ;;
esac

echo "[pi-install] Downloading: $URL"
if ! curl -fSL "$URL" -o "$ARCHIVE"; then
  echo "[pi-install] Failed to download Neovim archive; falling back to appimage (latest)"
  curl -fSL "https://github.com/neovim/neovim/releases/latest/download/nvim.appimage" -o "$TMPDIR/nvim.appimage" || true
  if [ -f "$TMPDIR/nvim.appimage" ]; then
    chmod +x "$TMPDIR/nvim.appimage"
    mv "$TMPDIR/nvim.appimage" "$INSTALL_DIR/nvim"
    chmod +x "$INSTALL_DIR/nvim"
    echo "[pi-install] Installed appimage as $INSTALL_DIR/nvim"
    rm -rf "$TMPDIR"
    exit 0
  else
    echo "[pi-install] No fallback available; aborting"
    rm -rf "$TMPDIR"
    exit 1
  fi
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

echo "[pi-install] Neovim ($NEOVIM_VERSION) installed to $INSTALL_DIR/nvim"

echo "Note: your shell config should include $HOME/.local/share/bob/nvim-bin in PATH (configs/zshrc already does this)"
