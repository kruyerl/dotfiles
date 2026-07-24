#!/usr/bin/env bash
set -euo pipefail

BOB_DIR="$HOME/.local/share/bob"
BOB_BIN="$BOB_DIR/bin/bob"

if command -v bob >/dev/null 2>&1 || [ -x "$BOB_BIN" ]; then
  echo "[pi-install] bob already installed: $(command -v bob || echo $BOB_BIN)"
  exit 0
fi

echo "[pi-install] Installing ModernNeovim/bob into $BOB_DIR"
mkdir -p "$BOB_DIR"

# Try the official install script
if curl -fsSL "https://raw.githubusercontent.com/ModernNeovim/bob/main/install.sh" | bash -s -- --to "$BOB_DIR"; then
  echo "[pi-install] bob installed to $BOB_DIR"
else
  echo "[pi-install] bob install script failed; attempting git clone fallback"
  if command -v git >/dev/null 2>&1; then
    git clone https://github.com/ModernNeovim/bob.git "$BOB_DIR/repo" || true
    # Try to run a minimal bootstrap if available
    if [ -x "$BOB_DIR/repo/install.sh" ]; then
      bash "$BOB_DIR/repo/install.sh" --to "$BOB_DIR" || true
    fi
  else
    echo "[pi-install] git not available; cannot clone bob. Please install bob manually."
    exit 1
  fi
fi

if [ -x "$BOB_BIN" ]; then
  echo "[pi-install] bob bin available at $BOB_BIN"
else
  echo "[pi-install] bob installed, but $BOB_BIN not found. You may need to add $BOB_DIR/bin to your PATH"
fi

echo "[pi-install] bob install step done"
