#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../lib/log.sh"

LOG_NAMESPACE="install:bob"
BOB_DIR="$HOME/.local/share/bob"
BOB_BIN="$BOB_DIR/bin/bob"
REPO_URL="https://github.com/mordechaihadad/bob.git"

if command -v bob >/dev/null 2>&1 || [ -x "$BOB_BIN" ]; then
  log_info "bob already installed: $(command -v bob || echo "$BOB_BIN")"
  exit 0
fi

if ! command -v git >/dev/null 2>&1; then
  log_error "git is required to install bob from $REPO_URL"
  exit 1
fi

log_info "installing bob from $REPO_URL into $BOB_DIR"
mkdir -p "$BOB_DIR"

if [ -d "$BOB_DIR/repo" ]; then
  log_info "bob repo already cloned; pulling updates"
  (cd "$BOB_DIR/repo" && git pull --ff-only) || true
else
  git clone "$REPO_URL" "$BOB_DIR/repo" || true
fi

if [ -x "$BOB_DIR/repo/install.sh" ]; then
  log_info "running bundled bob install script"
  bash "$BOB_DIR/repo/install.sh" --to "$BOB_DIR" || true
fi

if [ -x "$BOB_BIN" ]; then
  log_info "bob binary available at $BOB_BIN"
elif [ -x "$BOB_DIR/repo/bin/bob" ]; then
  mkdir -p "$BOB_DIR/bin"
  ln -sf "$BOB_DIR/repo/bin/bob" "$BOB_BIN"
  log_info "linked bob to $BOB_BIN"
else
  log_warn "bob repo cloned to $BOB_DIR/repo, but no bob binary was found"
  log_warn "add $BOB_DIR/repo/bin or $BOB_DIR/bin to your PATH and re-run"
fi

log_info "bob setup complete"
