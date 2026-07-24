#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../lib/log.sh"

LOG_NAMESPACE="install:apt"
PKGS=(
  software-properties-common
  build-essential
  wget
  tmux
  unzip
  fuse
  libfuse2
  ranger
  bat
  tree
  lsd
  ripgrep
  fzf
  fd-find
  make
  gcc
  ffmpeg
  p7zip-full
  jq
  poppler-utils
  zoxide
  imagemagick
)

log_info "updating apt cache"
sudo apt update -y

log_info "installing apt packages"
sudo apt install -y "${PKGS[@]}"

log_info "cleaning up apt packages"
sudo apt autoremove -y
sudo apt autoclean -y

log_info "apt package installation complete"
