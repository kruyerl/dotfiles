#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_PI="$SCRIPT_DIR"
DEFAULT_PI_DEST="$HOME/.pi/agent"
PI_DEST="$DEFAULT_PI_DEST"

if [ -n "${PI_CODING_AGENT_DIR:-}" ]; then
  if [ "$PI_CODING_AGENT_DIR" = "$CONFIG_PI" ]; then
    :
  elif [ -e "$PI_CODING_AGENT_DIR" ] && [ "$(readlink -f "$PI_CODING_AGENT_DIR")" = "$(readlink -f "$CONFIG_PI")" ]; then
    :
  else
    PI_DEST="$PI_CODING_AGENT_DIR"
  fi
fi

print_usage() {
  cat <<EOF
Usage: $0 [--help]

Symlink this repo-managed Pi config directory into the Pi agent config path.

Default target:
  ~/.pi/agent

If PI_CODING_AGENT_DIR is set to some other path, that path is used instead.
If it already points at this repo-managed config directory, the script still links
that directory into ~/.pi/agent.
EOF
}

while [[ ${#@} -gt 0 ]]; do
  case "$1" in
    -h|--help) print_usage; exit 0 ;;
    *) echo "Unknown arg: $1"; print_usage; exit 1 ;;
  esac
done

migrate_existing_agent_dir() {
  local backup_path timestamp
  timestamp="$(date +%Y%m%d-%H%M%S)"
  backup_path="${PI_DEST}.backup-$timestamp"

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
      echo "Moved $name into repo-managed Pi config"
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
    echo "Merged sessions into repo-managed Pi config"
  fi
}

seed_default_settings() {
  local settings_template settings_file
  settings_template="$CONFIG_PI/settings.example.json"
  settings_file="$CONFIG_PI/settings.json"

  if [ -e "$settings_file" ] || [ ! -f "$settings_template" ]; then
    return
  fi

  cp "$settings_template" "$settings_file"
  echo "Seeded $settings_file from $settings_template"
}

mkdir -p "$(dirname "$PI_DEST")"

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
seed_default_settings
