#!/usr/bin/env bash
set -euo pipefail

# systemInit.sh
# Interactive-first system initialization. This script installs zsh/git/curl
# then runs the interactive Oh My Zsh installer by default (which spawns zsh).
# If you prefer a non-interactive flow (for automation), pass --non-interactive
# and the script will clone Oh My Zsh and set up a template .zshrc instead.

MODE="interactive"

print_usage() {
  cat <<EOF
Usage: $0 [--non-interactive] [--help]

Default: interactive mode (runs the official Oh My Zsh installer which
may spawn an interactive zsh and stop further scripted steps). If you want
an automated non-interactive install (safe for CI/provisioning), use
--non-interactive.
EOF
}

while [[ ${#@} -gt 0 ]]; do
  case "$1" in
    --non-interactive) MODE="noninteractive"; shift ;;
    -h|--help) print_usage; exit 0 ;;
    *) echo "Unknown arg: $1"; print_usage; exit 1 ;;
  esac
done

# Install packages
sudo apt update
sudo apt upgrade -y
sudo apt install -y zsh git curl

if [ "$MODE" = "interactive" ]; then
  echo "Running the interactive Oh My Zsh installer. This may open zsh and stop this script."
  echo "After the installer completes, re-run any remaining setup steps (e.g., ./scripts/seedSetup.sh)."

  # Confirm with the user before running the interactive installer
  read -r -p "Proceed with the interactive Oh My Zsh installer? [y/N] " RESP
  RESP="${RESP:-N}"
  if [[ "$RESP" =~ ^[Yy] ]]; then
    # Run the official installer (interactive). It typically clones oh-my-zsh and then execs zsh.
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    # If control returns (installer didn't exec zsh), offer to run seedSetup.sh automatically
    echo
    read -r -p "Installer returned. Run seed setup now to link dotfiles? [y/N] " RUN_SEED
    RUN_SEED="${RUN_SEED:-N}"
    if [[ "$RUN_SEED" =~ ^[Yy] ]]; then
      echo "Running ./scripts/seedSetup.sh"
      bash "$(dirname "${BASH_SOURCE[0]}")/seedSetup.sh"
    else
      echo "Skipping seed setup. You can run ./scripts/seedSetup.sh later."
    fi
  else
    echo "Skipping interactive installer. Run ./scripts/systemInit.sh --non-interactive for automated setup or run the installer manually later."
  fi
  exit 0
else
  echo "Non-interactive mode: cloning Oh My Zsh and creating a template .zshrc"
  OMZ_DIR="$HOME/.oh-my-zsh"
  if [ -d "$OMZ_DIR" ]; then
    echo "Oh My Zsh already installed at $OMZ_DIR"
  else
    git clone https://github.com/ohmyzsh/ohmyzsh.git "$OMZ_DIR"
  fi

  if [ ! -f "$HOME/.zshrc" ]; then
    cp "$OMZ_DIR/templates/zshrc.zsh-template" "$HOME/.zshrc"
  fi

  echo "Non-interactive Oh My Zsh setup complete."
  echo "To change your login shell to zsh, run: chsh -s $(command -v zsh)"
fi

echo "systemInit.sh finished. If you ran interactive mode, continue with your manual steps (e.g., ./scripts/seedSetup.sh). If non-interactive, you can run ./scripts/seedSetup.sh now."