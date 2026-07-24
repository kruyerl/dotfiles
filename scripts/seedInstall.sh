#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "scripts/seedInstall.sh is a compatibility wrapper. Delegating to scripts/install.sh."
exec "$SCRIPT_DIR/install.sh" "$@"
