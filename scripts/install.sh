#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
INSTALL_DIR="$REPO_ROOT/scripts/install"

print_usage() {
  cat <<EOF
Usage: $0 [--help]

Runs the install phase for this dotfiles repo:
- package managers
- runtimes
- tools
EOF
}

while [[ ${#@} -gt 0 ]]; do
  case "$1" in
    -h|--help) print_usage; exit 0 ;;
    *) echo "Unknown arg: $1"; print_usage; exit 1 ;;
  esac
done

echo "Running install phase: package managers, runtimes, and tools"

run_if_exists() {
  local script="$1"
  if [ -x "$script" ] || [ -f "$script" ]; then
    echo "--- running $script"
    bash "$script"
  else
    echo "--- skipping $script (not found)"
  fi
}

run_if_exists "$INSTALL_DIR/apt-packages.sh"
run_if_exists "$INSTALL_DIR/rust.sh"
run_if_exists "$INSTALL_DIR/git-plugins.sh"
run_if_exists "$INSTALL_DIR/fnm.sh"
run_if_exists "$INSTALL_DIR/bob.sh"
run_if_exists "$INSTALL_DIR/neovim.sh"
run_if_exists "$INSTALL_DIR/yazi.sh"
run_if_exists "$INSTALL_DIR/zoxide.sh"
run_if_exists "$INSTALL_DIR/pi_install.sh"

echo
echo "Install phase complete."
echo "This phase covers package managers, runtimes, and tools."
echo "Next step: run ./scripts/setup.sh to link configs into your home directory."
