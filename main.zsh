#!/usr/bin/env zsh

set -e

# Resolve the directory where the master script is located
SCRIPT_DIR="${0:A:h}"
CONFIG_FILE="$SCRIPT_DIR/.tool-versions"

echo "🚀 Initiating Modular Development Environment Provisioning..."

# Pre-flight check: Ensure the configuration file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "❌ CRITICAL ERROR: Configuration file '$CONFIG_FILE' not found."
  echo "Please create it before running this provisioning script"
  exit 1
fi

echo "📄 Using configuration state from: $CONFIG_FILE"

# Execute child process
zsh "$SCRIPT_DIR/01_install_plugins.zsh"
zsh "$SCRIPT_DIR/02_install_system_deps.zsh"

# Source into current shell to preserve memory space and environment variables
echo "⚡ Sourcing compiler environment variables..."
source "$SCRIPT_DIR/03_configure_env_vars.zsh"

# Execute child process (inheriting the newly sourced environment)
zsh "$SCRIPT_DIR/04_install_runtimes.zsh"
zsh "$SCRIPT_DIR/05_set_globals.zsh"

echo "✅ Provisioning completed successfully. Execute 'source ~/.zshrc' to finaliz the shell environment."
