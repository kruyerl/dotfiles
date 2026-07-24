#!/usr/bin/env bash
set -euo pipefail

# Install bob from https://github.com/mordechaihadad/bob (per-user)
BOB_DIR="$HOME/.local/share/bob"
BOB_BIN="$BOB_DIR/bin/bob"
REPO_URL="https://github.com/mordechaihadad/bob.git"

if command -v bob >/dev/null 2>&1 || [ -x "$BOB_BIN" ]; then
  echo "[pi-install] bob already installed: $(command -v bob || echo $BOB_BIN)"
  exit 0
fi

echo "[pi-install] Installing bob from $REPO_URL into $BOB_DIR"
mkdir -p "$BOB_DIR"

if command -v git >/dev/null 2>&1; then
  if [ -d "$BOB_DIR/repo" ]; then
    echo "[pi-install] bob repo already cloned; pulling updates"
    (cd "$BOB_DIR/repo" && git pull --ff-only) || true
  else
    git clone "$REPO_URL" "$BOB_DIR/repo" || true
  fi
else
  echo "[pi-install] git is required to install bob from $REPO_URL. Install git and re-run." >&2
  exit 1
fi

# If the repo provides an install script, try to run it into the target dir
if [ -x "$BOB_DIR/repo/install.sh" ]; then
  echo "[pi-install] Running bundled install script"
  bash "$BOB_DIR/repo/install.sh" --to "$BOB_DIR" || true
fi

# If there's a bin/bob produced by the install, report it. Otherwise, try to
# expose the repo's bin directory if it exists.
if [ -x "$BOB_BIN" ]; then
  echo "[pi-install] bob bin available at $BOB_BIN"
elif [ -x "$BOB_DIR/repo/bin/bob" ]; then
  mkdir -p "$BOB_DIR/bin"
  ln -sf "$BOB_DIR/repo/bin/bob" "$BOB_BIN"
  echo "[pi-install] linked bob to $BOB_BIN"
else
  echo "[pi-install] bob repo cloned to $BOB_DIR/repo, but no bob binary found."
  echo "Add $BOB_DIR/repo/bin or $BOB_DIR/bin to your PATH and re-run." >&2
fi

echo "[pi-install] bob install step done"
