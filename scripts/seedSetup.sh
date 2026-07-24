#!/usr/bin/env bash
set -euo pipefail

# seedSetup.sh - wrapper to run post-system interactive setup steps
# Historically this performed symlinking and initial dotfile setup.
# It delegates to scripts/install/link-configs.sh for robust behavior.

echo "Running seed setup: linking dotfiles"

# Run link-configs in interactive mode (backup existing files)
bash "$(dirname "${BASH_SOURCE[0]}")/install/link-configs.sh" --backup

echo "Seed setup complete. You may need to reload your shell or log out and back in."