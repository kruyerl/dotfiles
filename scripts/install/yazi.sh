#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../lib/log.sh"

LOG_NAMESPACE="install:yazi"

if command -v yazi-fm >/dev/null 2>&1 || command -v yazi-cli >/dev/null 2>&1; then
  log_info "yazi already installed; skipping"
  exit 0
fi

if ! command -v cargo >/dev/null 2>&1; then
  log_warn "cargo not found; skipping yazi install"
  exit 0
fi

log_info "installing yazi via cargo"
cargo install --locked --git https://github.com/sxyazi/yazi.git yazi-fm yazi-cli || true

log_info "yazi install step complete"
