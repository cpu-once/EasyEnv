#!/usr/bin/env zsh
set -e

SCRIPT_DIR="${0:A:h}"
CONFIG_FILE="$SCRIPT_DIR/.tool-versions"


echo "🌍 Phase 5: Setting global versions and regenerating shims..."

awk '/^[^# \t]/ {print $1, $2}' "$CONFIG_FILE" | while read -r plugin version; do
  echo "Binding global system default: $plugin -> $version"
  asdf set -u "$plugin" "$version"
done

# Regenerate executable shims to map standard commands (e.g., 'python) to asdf
asdf reshim
