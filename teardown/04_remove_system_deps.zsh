#!/usr/bin/env zsh
set -e

echo "📦 Phase 4: Purging compilation dependcies (Homebrew)..."

# Define the exact manifest from your original bootstrap script
DEPS=(openssl readline sqlite3 xz zlib tcl-tk)

for pkg in "${DEPS[@]}"; do
  if brew list "$pkg" &>/dev/null; then
    echo "Uninstalling $pkg ..."
    # We capture the exit code gracefully. If another brew package depends on it,
    # Homebrew will safely block the uninstallation.
    brew uninstall "$pkg" || echo "⚠️ Skipped $pkg (Likely retained by another system dependency)."
  fi
done
