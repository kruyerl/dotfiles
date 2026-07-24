#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../lib/log.sh"

LOG_NAMESPACE="install:neovim"
NEOVIM_VERSION="${NEOVIM_VERSION:-nightly}"
INSTALL_DIR="$HOME/.local/share/bob/nvim-bin"
mkdir -p "$INSTALL_DIR"

if command -v nvim >/dev/null 2>&1; then
  log_info "nvim already available in PATH: $(command -v nvim)"
  exit 0
fi

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

ARCHIVE="$TMPDIR/nvim.tar.gz"
EXTRACT_DIR="$TMPDIR/extract"
mkdir -p "$EXTRACT_DIR"

log_info "installing Neovim ($NEOVIM_VERSION) into $INSTALL_DIR"

case "$NEOVIM_VERSION" in
  nightly)
    URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz"
    ;;
  latest)
    URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz"
    ;;
  *)
    URL="https://github.com/neovim/neovim/releases/download/${NEOVIM_VERSION}/nvim-linux64.tar.gz"
    ;;
esac

clear_install_dir() {
  find "$INSTALL_DIR" -mindepth 1 -maxdepth 1 -exec rm -rf {} +
}

install_appimage_fallback() {
  log_warn "failed to download Neovim archive; falling back to latest appimage"
  curl -fSL "https://github.com/neovim/neovim/releases/latest/download/nvim.appimage" -o "$TMPDIR/nvim.appimage"
  clear_install_dir
  mv "$TMPDIR/nvim.appimage" "$INSTALL_DIR/nvim"
  chmod +x "$INSTALL_DIR/nvim"
  log_info "installed appimage as $INSTALL_DIR/nvim"
}

log_info "downloading $URL"
if ! curl -fSL "$URL" -o "$ARCHIVE"; then
  install_appimage_fallback
  exit 0
fi

tar -xzf "$ARCHIVE" -C "$EXTRACT_DIR"

EXTRACTED_ROOT="$(find "$EXTRACT_DIR" -mindepth 1 -maxdepth 1 -type d -print -quit)"
if [ -z "$EXTRACTED_ROOT" ]; then
  log_error "couldn't find extracted Neovim directory"
  exit 1
fi

if [ ! -x "$EXTRACTED_ROOT/bin/nvim" ]; then
  log_error "couldn't find nvim binary in extracted archive"
  exit 1
fi

clear_install_dir
cp -a "$EXTRACTED_ROOT"/. "$INSTALL_DIR"/
ln -sfn "$INSTALL_DIR/bin/nvim" "$INSTALL_DIR/nvim"

log_info "Neovim ($NEOVIM_VERSION) installed to $INSTALL_DIR"
log_info "exposed executable at $INSTALL_DIR/nvim"
log_info "ensure $HOME/.local/share/bob/nvim-bin is in PATH (configs/zshrc already does this)"
