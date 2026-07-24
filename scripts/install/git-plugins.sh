#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../lib/log.sh"

LOG_NAMESPACE="install:zsh-plugins"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins"

if ! command -v git >/dev/null 2>&1; then
  log_error "git is required to install zsh plugins"
  exit 1
fi

log_info "installing zsh plugins into $ZSH_CUSTOM/plugins"

clone_if_missing() {
  local url="$1"
  local dest="$2"

  if [ -d "$dest" ]; then
    log_info "$dest exists; skipping"
  else
    git clone "$url" "$dest"
  fi
}

clone_if_missing "https://github.com/zsh-users/zsh-autosuggestions" "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_if_missing "https://github.com/zsh-users/zsh-history-substring-search" "$ZSH_CUSTOM/plugins/zsh-history-substring-search"
clone_if_missing "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

log_info "zsh plugin installation complete"
