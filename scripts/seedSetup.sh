#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "scripts/seedSetup.sh is a compatibility wrapper. Delegating to scripts/setup.sh."
exec "$SCRIPT_DIR/setup.sh" "$@"
