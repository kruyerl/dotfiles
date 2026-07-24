#!/usr/bin/env bash
set -euo pipefail

# scripts/install/link-configs.sh
# Create symlinks from repo-managed dotfiles into $HOME
# Usage: ./scripts/install/link-configs.sh [--dry-run] [--backup]

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && cd .. && pwd)"

DRY_RUN=0
BACKUP=0

print_usage() {
  cat <<EOF
Usage: $0 [--dry-run] [--backup]

Options:
  --dry-run   Print actions without making changes
  --backup    Move existing target files to <target>.backup before linking

This script creates symlinks for a small set of config files from the
repo into your home directory. It is safe to re-run.
EOF
}

while [[ ${#@} -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=1; shift ;;
    --backup) BACKUP=1; shift ;;
    -h|--help) print_usage; exit 0 ;;
    *) echo "Unknown arg: $1"; print_usage; exit 1 ;;
  esac
done

link() {
  local src="$1"
  local dest="$2"

  echo "Link: $dest -> $src"
  if [ $DRY_RUN -eq 1 ]; then
    return
  fi

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    if [ -L "$dest" ] && [ "$(readlink -f "$dest")" = "$src" ]; then
      echo "  -> already correct symlink"
      return
    fi

    if [ $BACKUP -eq 1 ]; then
      echo "  -> backing up existing $dest to ${dest}.backup"
      rm -f "${dest}.backup"
      mv "$dest" "${dest}.backup"
    else
      echo "  -> removing existing $dest"
      rm -rf "$dest"
    fi
  fi

  mkdir -p "$(dirname "$dest")"
  ln -sfn "$src" "$dest"
}

# Mappings: repo path -> target path
link "$REPO_ROOT/configs/zshrc" "$HOME/.zshrc"
link "$REPO_ROOT/configs/tmux.conf" "$HOME/.tmux.conf"
link "$REPO_ROOT/configs/nvim" "$HOME/.config/nvim"

# Optional assets (only link if present)
if [ -d "$REPO_ROOT/assets/wallpapers" ]; then
  link "$REPO_ROOT/assets/wallpapers" "$HOME/Pictures/Wallpapers"
fi

if [ -d "$REPO_ROOT/assets/fonts" ]; then
  link "$REPO_ROOT/assets/fonts" "$HOME/.local/share/fonts/dotfiles"
fi

echo "Done"
