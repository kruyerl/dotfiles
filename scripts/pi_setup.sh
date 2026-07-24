#!/usr/bin/env bash

# Copy project-local .pi configuration into the user's pi directory
# Run this from the repo root: ./scripts/pi_setup.sh

set -euo pipefail

REPO_ROOT="$(pwd)"
PI_DEST="$HOME/.pi/agent"

if [ ! -d "$REPO_ROOT/.pi" ]; then
  echo "No .pi directory in repository. Create .pi/ and add settings, prompts, extensions as needed."
  exit 1
fi

mkdir -p "$PI_DEST"
rsync -av --exclude '.git' "$REPO_ROOT/.pi/" "$PI_DEST/"

echo "Copied .pi/ -> $PI_DEST"

echo "Done. Start pi with: pi"