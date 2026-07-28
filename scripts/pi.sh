#!/usr/bin/env bash
# scripts/pi.sh - set up Pi from this dotfiles repository
# Usage: ./scripts/pi.sh [--install] [--install-deps] [--install-packages] [--help]

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_PI="$REPO_ROOT/configs/pi"
LINK_SCRIPT="$CONFIG_PI/link.sh"
# shellcheck disable=SC1091
source "$REPO_ROOT/scripts/lib/node.sh"

DO_INSTALL=0
DO_INSTALL_DEPS=0
DO_INSTALL_PACKAGES=0

# Pi packages this setup expects to be installed (via 'pi install').
# settings.json is machine-local, so these must be (re)installed on each new machine.
PI_PACKAGES=(
  "npm:pi-web-access"
)

print_usage() {
  cat <<EOF
Usage: $0 [options]
Options:
  --install           Run ./scripts/npm to install pi (and other npm tools)
  --install-deps      Install npm deps for configs/pi (uses --ignore-scripts)
  --install-packages  Install pi packages (e.g. pi-web-access) via 'pi install'
  --help              Show this help

This script links $CONFIG_PI into the Pi config directory by calling:
  $LINK_SCRIPT

The target defaults to ~/.pi/agent and honors PI_CODING_AGENT_DIR when it
points somewhere other than this repo-managed config directory.

Note about installing deps: install-deps will run "npm install --omit=dev --ignore-scripts"
in configs/pi. This avoids running project "prepare" scripts that may require
developer tooling.
EOF
}

while [[ ${#@} -gt 0 ]]; do
  case "$1" in
    --install) DO_INSTALL=1; shift ;;
    --install-deps) DO_INSTALL_DEPS=1; shift ;;
    --install-packages) DO_INSTALL_PACKAGES=1; shift ;;
    --help) print_usage; exit 0 ;;
    *) echo "Unknown arg: $1"; print_usage; exit 1 ;;
  esac
done

if [ ! -d "$CONFIG_PI" ]; then
  echo "Error: expected $CONFIG_PI to exist." >&2
  exit 1
fi

if [ ! -f "$LINK_SCRIPT" ]; then
  echo "Error: expected Pi link script at $LINK_SCRIPT." >&2
  exit 1
fi

bash "$LINK_SCRIPT"

if [ "$DO_INSTALL" -eq 1 ]; then
  ensure_node_runtime

  if [ -x "$REPO_ROOT/scripts/npm" ] || [ -f "$REPO_ROOT/scripts/npm" ]; then
    echo "Running $REPO_ROOT/scripts/npm"
    bash "$REPO_ROOT/scripts/npm"
    echo "Finished npm helper"
  else
    echo "No scripts/npm helper found; skipping install" >&2
  fi
fi

if [ "$DO_INSTALL_DEPS" -eq 1 ]; then
  ensure_node_runtime

  echo "Installing npm deps in $CONFIG_PI (ignore scripts)"
  (cd "$CONFIG_PI" && npm install --omit=dev --ignore-scripts)

  echo "Dependency install complete for configs/pi."
  echo "If you need extension-local development builds, run installs in those extension folders manually."
fi

if [ "$DO_INSTALL_PACKAGES" -eq 1 ]; then
  if command -v pi >/dev/null 2>&1; then
    for pkg in "${PI_PACKAGES[@]}"; do
      echo "Installing pi package: $pkg"
      pi install "$pkg"
    done
  else
    echo "pi CLI not found on PATH; skipping package install" >&2
  fi
fi

echo "Done. Start pi with: pi"
