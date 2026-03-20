#!/usr/bin/env zsh
set -e

SCRIPT_DIR="${0:A:h}"
LOCAL_CONFIG="$SCRIPT_DIR/.tool-versions"
GLOBAL_CONFIG="$HOME/.tool-versions"
ASDF_USER_DIR="$HOME/.asdf"

echo "🧨 Phase 5: Destroying user-space isolation core..."

# 1. Remove Homebrew installation of asdf if it exists
if brew list asdf &>/dev/null; then
    echo "Uninstalling core asdf binary from Homebrew..."
    brew uninstall asdf || true
fi

# 2. Nuke the user-space state map and shim directory
if [[ -d "$ASDF_USER_DIR" ]]; then
    echo "Erasing shim interception directory: $ASDF_USER_DIR"
    rm -rf "$ASDF_USER_DIR"
fi

# 3. Delete configuration manifests
if [[ -f "$GLOBAL_CONFIG" ]]; then
    echo "Removing global state file: $GLOBAL_CONFIG"
    rm -f "$GLOBAL_CONFIG"
fi

if [[ -f "$LOCAL_CONFIG" ]]; then
    echo "Removing local project state file: $LOCAL_CONFIG"
    rm -f "$LOCAL_CONFIG"
fi

echo "✅ Core layer eradicated."
