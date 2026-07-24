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

if ! cargo install --locked --force yazi-build; then
  log_warn "failed to install yazi-build helper; skipping yazi install"
  exit 0
fi

if cargo install --locked yazi-fm yazi-cli; then
  log_info "yazi install complete"
  exit 0
fi

log_warn "crates.io install failed; retrying from git source"
if ! cargo install --locked --git https://github.com/sxyazi/yazi.git yazi-fm yazi-cli; then
  log_warn "yazi install failed; continuing without yazi"
fi

log_info "yazi install step complete"
