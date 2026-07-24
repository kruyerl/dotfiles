#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/log.sh"

LOG_NAMESPACE="${LOG_NAMESPACE:-install:node}"
FNM_INSTALL_DIR="${FNM_INSTALL_DIR:-$HOME/.local/share/fnm}"
NODE_INSTALL_CHANNEL="${NODE_INSTALL_CHANNEL:-lts}"

setup_fnm_path() {
  if command -v fnm >/dev/null 2>&1; then
    return 0
  fi

  if [ -x "$FNM_INSTALL_DIR/fnm" ]; then
    export PATH="$FNM_INSTALL_DIR:$PATH"
  fi
}

load_fnm_env() {
  setup_fnm_path

  if ! command -v fnm >/dev/null 2>&1; then
    return 1
  fi

  eval "$(fnm env --shell bash)"
}

ensure_node_runtime() {
  load_fnm_env || {
    log_error "fnm is not available. Run scripts/install/fnm.sh first."
    return 1
  }

  local current_version
  current_version="$(fnm current 2>/dev/null || true)"

  if [ -n "$current_version" ] && [ "$current_version" != "system" ] && command -v node >/dev/null 2>&1 && command -v npm >/dev/null 2>&1; then
    log_info "using fnm-managed node $(node --version) and npm $(npm --version)"
    return 0
  fi

  log_info "installing Node.js via fnm"
  case "$NODE_INSTALL_CHANNEL" in
    lts|lts-latest)
      fnm install --lts --corepack-enabled
      ;;
    latest)
      fnm install --latest --corepack-enabled
      ;;
    *)
      fnm install "$NODE_INSTALL_CHANNEL" --corepack-enabled
      ;;
  esac

  load_fnm_env

  local resolved_version
  resolved_version="$(fnm current)"
  if [ -z "$resolved_version" ] || [ "$resolved_version" = "system" ]; then
    log_error "fnm did not activate a Node.js version as expected."
    return 1
  fi

  fnm default "$resolved_version"

  if command -v corepack >/dev/null 2>&1; then
    corepack enable >/dev/null 2>&1 || true
  fi

  log_info "using fnm-managed node $(node --version) and npm $(npm --version)"
}
