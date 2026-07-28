#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_usage() {
  cat <<EOF
Usage: $0 [--skip-pi] [--help]

Links repo-managed configs into your home directory.
By default it also links the Pi config, seeds local Pi settings when missing,
installs its local dependencies, and installs configured Pi packages when the
pi CLI is available.

Options:
  --skip-pi   Link dotfiles but skip Pi setup
  --help      Show this help
EOF
}

SETUP_PI=1

while [[ ${#@} -gt 0 ]]; do
  case "$1" in
    --skip-pi) SETUP_PI=0; shift ;;
    -h|--help) print_usage; exit 0 ;;
    *) echo "Unknown arg: $1"; print_usage; exit 1 ;;
  esac
done

echo "Running setup phase: linking dotfiles"
bash "$SCRIPT_DIR/install/link-configs.sh" --backup

if [ "$SETUP_PI" -eq 1 ]; then
  echo "Running Pi setup"
  bash "$SCRIPT_DIR/pi.sh" --install-deps --install-packages
fi

echo "Setup phase complete. You may need to reload your shell or log out and back in."
