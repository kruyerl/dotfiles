#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_NAMESPACE="install:node"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../lib/log.sh"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../lib/node.sh"

if ! command -v fnm >/dev/null 2>&1; then
  log_info "installing Fast Node Manager (fnm)"
  curl -fsSL https://fnm.vercel.app/install | bash --skip-shell
else
  log_info "fnm already installed"
fi

ensure_node_runtime

log_info "fnm + Node.js setup complete"
