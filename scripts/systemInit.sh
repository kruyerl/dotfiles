#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE="all"

print_usage() {
  cat <<EOF
Usage: $0 [--install-only] [--setup-only] [--help]

This repo is intended to be cloned after git is already set up.

Default behavior:
  1. run ./scripts/install.sh
  2. run ./scripts/setup.sh

Options:
  --install-only   Run only the install phase
  --setup-only     Run only the setup/linking phase
  --help           Show this help
EOF
}

while [[ ${#@} -gt 0 ]]; do
  case "$1" in
    --install-only) MODE="install"; shift ;;
    --setup-only) MODE="setup"; shift ;;
    -h|--help) print_usage; exit 0 ;;
    *) echo "Unknown arg: $1"; print_usage; exit 1 ;;
  esac
done

case "$MODE" in
  all)
    bash "$SCRIPT_DIR/install.sh"
    bash "$SCRIPT_DIR/setup.sh"
    ;;
  install)
    bash "$SCRIPT_DIR/install.sh"
    ;;
  setup)
    bash "$SCRIPT_DIR/setup.sh"
    ;;
esac
