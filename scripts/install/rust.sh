#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../lib/log.sh"

LOG_NAMESPACE="install:rust"

if command -v rustup >/dev/null 2>&1; then
  log_info "rustup already installed; updating"
  rustup update || true
  exit 0
fi

log_info "installing rustup"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# shellcheck disable=SC1090
. "$HOME/.cargo/env" || true
rustup update || true

log_info "Rust setup complete"
