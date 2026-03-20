#! /usr/bin/env zsh
set -e

SCRIPT_DIR="${0:A:h}"
CONFIG_FILE="$SCRIPT_DIR/.tool-versions"

echo "🗑️ Phase 1: Gracefully uninstalling language runtimes.."

if [[ -f "$CONFIG_FILE" ]]; then
  awk '/^[^# \t]/ {print $1, $2}' "$CONFIG_FILE" | while read -r plugin version; do
    # We use || true to prevent the pipeline from halting if the runtime is already deleted
    if asdf list "$plugin" "$version" >/dev/null 2>&1; then
      echo "Uninstalling target: $plugin $version ..."
      asdf uninstall "$plugin" "$version" || true
    else
     echo "Target already absent: $plugin $version"
    fi
  done
else
  echo "⚠️ No local .tool-versions file found. Assuming runtimes are already decoupled."
fi
