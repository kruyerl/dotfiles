#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INSTALL_DIR="$REPO_ROOT/scripts/install"

echo "Running seed installer (orchestrator)"

run_if_exists() {
  local script="$1"
  if [ -x "$script" ] || [ -f "$script" ]; then
    echo "--- running $script"
    bash "$script"
  else
    echo "--- skipping $script (not found)"
  fi
}

# Order matters: apt packages first
run_if_exists "$INSTALL_DIR/apt-packages.sh"
run_if_exists "$INSTALL_DIR/rust.sh"
run_if_exists "$INSTALL_DIR/git-plugins.sh"
run_if_exists "$INSTALL_DIR/neovim.sh"
run_if_exists "$INSTALL_DIR/yazi.sh"
run_if_exists "$INSTALL_DIR/zoxide.sh"
run_if_exists "$INSTALL_DIR/fnm.sh"
run_if_exists "$INSTALL_DIR/bob.sh"

# Install neovim (bob-aware)
run_if_exists "$INSTALL_DIR/neovim.sh"

# Install pi (npm helper)
run_if_exists "$INSTALL_DIR/pi_install.sh"

# Copy project-local .pi config into ~/.pi/agent (if present in repo root)
if [ -d "$REPO_ROOT/.pi" ]; then
  echo "Installing project-local .pi config into ~/.pi/agent"
  mkdir -p "$HOME/.pi/agent"
  rsync -av --exclude '.git' "$REPO_ROOT/.pi/" "$HOME/.pi/agent/"
fi

# Source zsh config if present (best-effort)
if [ -f "$HOME/.zshrc" ]; then
  # shellcheck disable=SC1090
  source "$HOME/.zshrc" || true
fi

echo "Seed install complete"

