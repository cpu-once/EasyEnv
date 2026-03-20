#!/usr/bin/env zsh
set -e

echo "🔌 Phase 2: Removing runtime routing plugins..."

#Retrieve all currently installed plugins and remove them
for plugin in $(asdf plugin list 2>/dev/null || true); do
  echo "Removing plugin repository: $plugin"
  asdf plugin remove "$plugin" || true
done
