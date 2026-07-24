#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
NPM_HELPER="$REPO_ROOT/scripts/npm"
LOG_NAMESPACE="install:pi"
# shellcheck disable=SC1091
source "$REPO_ROOT/scripts/lib/log.sh"
# shellcheck disable=SC1091
source "$REPO_ROOT/scripts/lib/node.sh"

ensure_node_runtime

if [ -f "$NPM_HELPER" ]; then
  log_info "running npm helper to install Pi and global npm tools"
  bash "$NPM_HELPER"
else
  log_warn "npm helper not found at $NPM_HELPER; skipping"
fi

log_info "Pi install step complete"
