#!/usr/bin/env bash
set -euo pipefail

# Install required apt packages (idempotent)
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

echo "[pi-install] Updating apt cache"
sudo apt update -y

echo "[pi-install] Installing apt packages"
sudo apt install -y "${PKGS[@]}"

# Housekeeping
sudo apt autoremove -y
sudo apt autoclean -y

echo "[pi-install] apt packages done"
