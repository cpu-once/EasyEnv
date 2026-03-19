#!/usr/bin/env zsh
set -e

SCRIPT_DIR="${0:A:h}"
CONFIG_FILE="$SCRIPT_DIR/.tool-versions"

echo "🛠️ Phase 4: Compiling and installing language runtimes..."
# Read line by line, mapping to plugin and version variables
awk '/^[^# \t]/ {print $1, $2}' "$CONFIG_FILE" | while read -r plugin version; do
echo "Processing compilation target:$plugin "$version"..."
  asdf install "$plugin" "$version"
done
