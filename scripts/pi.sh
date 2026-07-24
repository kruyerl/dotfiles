#!/usr/bin/env bash
# scripts/pi.sh - set up Pi from this dotfiles repository
# Usage: ./scripts/pi.sh [--install] [--install-deps] [--help]

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_PI="$REPO_ROOT/configs/pi"
PI_DEST="$HOME/.pi/agent"
# shellcheck disable=SC1091
source "$REPO_ROOT/scripts/lib/node.sh"

DO_INSTALL=0
DO_INSTALL_DEPS=0

print_usage() {
  cat <<EOF
Usage: $0 [options]
Options:
  --install          Run ./scripts/npm to install pi (and other npm tools)
  --install-deps     Install npm deps for configs/pi and extensions (uses --ignore-scripts)
  --help             Show this help

This script creates (or updates) a symlink at ~/.pi/agent -> $CONFIG_PI.

Run this from the repo (script handles locating the repo root).

Note about installing deps: install-deps will run "npm install --omit=dev --ignore-scripts"
in configs/pi and any extension subfolders that have a package.json. This avoids running
project "prepare" scripts that may require developer tooling.
EOF
}

while [[ ${#@} -gt 0 ]]; do
  case "$1" in
    --install) DO_INSTALL=1; shift ;;
    --install-deps) DO_INSTALL_DEPS=1; shift ;;
    --help) print_usage; exit 0 ;;
    *) echo "Unknown arg: $1"; print_usage; exit 1 ;;
  esac
done

if [ ! -d "$CONFIG_PI" ]; then
  echo "Error: expected $CONFIG_PI to exist. Create configs/pi/ with pi files first." >&2
  exit 1
fi

migrate_existing_agent_dir() {
  local backup_path timestamp
  timestamp="$(date +%Y%m%d-%H%M%S)"
  backup_path="$HOME/.pi/agent.backup-$timestamp"

  echo "Found an existing directory at $PI_DEST; migrating it to a symlink"
  mv "$PI_DEST" "$backup_path"
  ln -s "$CONFIG_PI" "$PI_DEST"
  echo "Backed up previous contents to: $backup_path"

  for name in auth.json models-store.json settings.json .env .env.local; do
    local src dst
    src="$backup_path/$name"
    dst="$CONFIG_PI/$name"

    if [ ! -e "$src" ]; then
      continue
    fi

    if [ ! -e "$dst" ]; then
      mv "$src" "$dst"
      echo "Moved $name into repo-managed pi config"
      continue
    fi

    if cmp -s "$src" "$dst"; then
      rm -f "$src"
      echo "Skipped identical $name"
      continue
    fi

    echo "Kept existing $dst; review backup copy at $src if you need it"
  done

  if [ -d "$backup_path/sessions" ]; then
    mkdir -p "$CONFIG_PI/sessions"
    cp -a "$backup_path/sessions/." "$CONFIG_PI/sessions/"
    echo "Merged sessions into repo-managed pi config"
  fi
}

mkdir -p "$HOME/.pi"

if [ -L "$PI_DEST" ]; then
  ln -sfn "$CONFIG_PI" "$PI_DEST"
elif [ -d "$PI_DEST" ]; then
  migrate_existing_agent_dir
elif [ -e "$PI_DEST" ]; then
  rm -f "$PI_DEST"
  ln -s "$CONFIG_PI" "$PI_DEST"
else
  ln -s "$CONFIG_PI" "$PI_DEST"
fi

echo "Created/updated symlink: $PI_DEST -> $CONFIG_PI"

if [ "$DO_INSTALL" -eq 1 ]; then
  ensure_node_runtime

  if [ -x "$REPO_ROOT/scripts/npm" ] || [ -f "$REPO_ROOT/scripts/npm" ]; then
    echo "Running $REPO_ROOT/scripts/npm"
    bash "$REPO_ROOT/scripts/npm"
    echo "Finished npm helper"
  else
    echo "No scripts/npm helper found; skipping install" >&2
  fi
fi

if [ "$DO_INSTALL_DEPS" -eq 1 ]; then
  ensure_node_runtime

  echo "Installing npm deps in $CONFIG_PI (ignore scripts)"
  (cd "$CONFIG_PI" && npm install --omit=dev --ignore-scripts)

  for ext in "$CONFIG_PI"/extensions/*; do
    if [ -f "$ext/package.json" ]; then
      echo "Installing deps for extension: $(basename "$ext")"
      (cd "$ext" && npm install --omit=dev --ignore-scripts) || true
    fi
  done

  echo "Dependency installs complete. If you need development builds or to run prepare scripts,"
  echo "re-run installs without --ignore-scripts or follow extension-specific instructions in SETUP.md."
fi

echo "Done. Start pi with: pi"
