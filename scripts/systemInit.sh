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

# AUTO_ACCEPT_INSTALL=1 will skip confirmation and run the interactive installer
# AUTO_RUN_SEED=1 will automatically run seedSetup.sh if the installer returns
AUTO_ACCEPT_INSTALL="${AUTO_ACCEPT_INSTALL:-0}"
AUTO_RUN_SEED="${AUTO_RUN_SEED:-0}"

if [ "$MODE" = "interactive" ]; then
  echo "Running the interactive Oh My Zsh installer. This may open zsh and stop this script."
  echo "After the installer completes, re-run any remaining setup steps (e.g., ./scripts/seedSetup.sh)."

  if [ "$AUTO_ACCEPT_INSTALL" = "1" ]; then
    echo "AUTO_ACCEPT_INSTALL=1: proceeding without prompt"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    RETURNED=0
  else
    # Confirm with the user before running the interactive installer
    read -r -p "Proceed with the interactive Oh My Zsh installer? [y/N] " RESP
    RESP="${RESP:-N}"
    if [[ "$RESP" =~ ^[Yy] ]]; then
      sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
      RETURNED=0
    else
      echo "Skipping interactive installer. Run ./scripts/systemInit.sh --non-interactive for automated setup or run the installer manually later."
      exit 0
    fi
  fi

  # If control returns (installer didn't exec zsh), optionally run seed setup
  if [ "$AUTO_RUN_SEED" = "1" ]; then
    echo "AUTO_RUN_SEED=1: running seed setup now"
    bash "$(dirname "${BASH_SOURCE[0]}")/seedSetup.sh"
  else
    echo
    read -r -p "Installer returned. Run seed setup now to link dotfiles? [y/N] " RUN_SEED
    RUN_SEED="${RUN_SEED:-N}"
    if [[ "$RUN_SEED" =~ ^[Yy] ]]; then
      echo "Running ./scripts/seedSetup.sh"
      bash "$(dirname "${BASH_SOURCE[0]}")/seedSetup.sh"
    else
      echo "Skipping seed setup. You can run ./scripts/seedSetup.sh later."
    fi
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