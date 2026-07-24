#!/usr/bin/env bash
set -euo pipefail

# Minimal system initialization: install zsh, git, curl and Oh My Zsh non-interactively.
# This script avoids launching an interactive zsh or changing the login shell unless
# AUTO_CHSH=1 is set. Run with sudo for system package installs; the user that invoked
# sudo will be preserved for optional chsh.

# Update packages and install prerequisites
sudo apt update
sudo apt upgrade -y
sudo apt install -y zsh git curl

# Install Oh My Zsh by cloning to avoid the interactive installer which spawns zsh
OMZ_DIR="$HOME/.oh-my-zsh"
if [ -d "$OMZ_DIR" ]; then
  echo "Oh My Zsh already installed at $OMZ_DIR"
else
  echo "Cloning Oh My Zsh into $OMZ_DIR"
  git clone https://github.com/ohmyzsh/ohmyzsh.git "$OMZ_DIR"
fi

# Create a default .zshrc from the template if the user doesn't have one
if [ ! -f "$HOME/.zshrc" ]; then
  echo "Installing default .zshrc from Oh My Zsh template"
  cp "$OMZ_DIR/templates/zshrc.zsh-template" "$HOME/.zshrc"
fi

# Do NOT exec zsh here. The original installer launches zsh which stops further script
# execution. If you want to switch the login shell automatically, set AUTO_CHSH=1
# before running this script (requires sudo to change another user's shell).

# Determine target user for chsh (preserve SUDO_USER when run with sudo)
TARGET_USER="${SUDO_USER:-$USER}"
ZSH_PATH="$(command -v zsh || printf '/usr/bin/zsh')"

if [ "${AUTO_CHSH:-0}" = "1" ]; then
  echo "Attempting to change login shell to $ZSH_PATH for user $TARGET_USER"
  if [ "$(id -u)" -eq 0 ]; then
    # Running as root: change target user's shell
    chsh -s "$ZSH_PATH" "$TARGET_USER" || echo "chsh failed; run manually: chsh -s $ZSH_PATH $TARGET_USER"
  else
    # Not root: change current user
    chsh -s "$ZSH_PATH" "$TARGET_USER" || echo "chsh failed; run manually: chsh -s $ZSH_PATH $TARGET_USER"
  fi
else
  echo "To change your login shell to zsh, run:
  chsh -s $ZSH_PATH $TARGET_USER
Or set AUTO_CHSH=1 and re-run this script to attempt it automatically."
fi

echo "System init complete. Start a new login session or run 'exec zsh' to test zsh now."