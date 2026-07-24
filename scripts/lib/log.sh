#!/usr/bin/env bash
set -euo pipefail

LOG_NAMESPACE="${LOG_NAMESPACE:-script}"

log_info() {
  printf '[%s] %s\n' "$LOG_NAMESPACE" "$*"
}

log_warn() {
  printf '[%s] WARN: %s\n' "$LOG_NAMESPACE" "$*" >&2
}

log_error() {
  printf '[%s] ERROR: %s\n' "$LOG_NAMESPACE" "$*" >&2
}
