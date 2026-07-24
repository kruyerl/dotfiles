#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../lib/log.sh"

LOG_NAMESPACE="install:zoxide"

if command -v zoxide >/dev/null 2>&1; then
  log_info "zoxide already installed; skipping"
  exit 0
fi

log_info "installing zoxide"
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh || true

log_info "zoxide install step complete"
