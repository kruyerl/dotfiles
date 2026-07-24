#!/usr/bin/env bash
set -euo pipefail

ZSH_CUSTOM=${ZSH_CUSTOM:-"$HOME/.oh-my-zsh/custom"}
mkdir -p "$ZSH_CUSTOM/plugins"

echo "[pi-install] Installing zsh plugins into $ZSH_CUSTOM/plugins"

clone_if_missing() {
  local url=$1
  local dest=$2
  if [ -d "$dest" ]; then
    echo "  - $dest exists; skipping"
  else
    git clone "$url" "$dest"
  fi
}

clone_if_missing "https://github.com/zsh-users/zsh-autosuggestions" "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_if_missing "https://github.com/zsh-users/zsh-history-substring-search" "$ZSH_CUSTOM/plugins/zsh-history-substring-search"
clone_if_missing "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

echo "[pi-install] zsh plugins done"
