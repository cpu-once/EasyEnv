#!/usr/bin/env zsh
set -e

# Resolve the directory of this script to locate the config file
SCRIPT_DIR="${0:A:h}"
CONFIG_FILE="$SCRIPT_DIR/.tool-versions"

echo "🔌 Phase 1: Updating and installing asdf plugins from configuration..."

asdf plugin update --all || true

#Extract only the first column (plugin names), ignoring empty lines/comments
awk '/^[^# \t]/ {print $1}' "$CONFIG_FILE" | while read -r plugin; do
  if ! asdf plugin list | grep -q "^${plugin}"; then
    echo "Adding plugin: $plugin"
    asdf plugin add "$plugin" || echo "Warning: Plugin $plugin might alredy exist."
  fi
done
