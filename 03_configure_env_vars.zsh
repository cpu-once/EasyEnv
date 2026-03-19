#!/usr/bin/env zsh
# Do not use 'set -e' here if sourced directly in interactive shells, 
# but safe when orchestrated by main.zsh

echo "⚙️ Phase 3: Configuring environment variables..."

ZSHRC_FILE="$HOME/.zshrc"

append_env_var() {
    local search_string="$1"
    local export_command="$2"
    if ! grep -q "$search_string" "$ZSHRC_FILE"; then
        echo "$export_command" >> "$ZSHRC_FILE"
    fi
}

# 1. Java Configuration
append_env_var "set-java-home.zsh" ". ~/.asdf/plugins/java/set-java-home.zsh"

# 2. Python Build Constraints
# Exporting to current session so Phase 4 inherits these
export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"
export LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix readline)/lib -L$(brew --prefix sqlite3)/lib -L$(brew --prefix zlib)/lib"
export CPPFLAGS="-I$(brew --prefix openssl)/include -I$(brew --prefix readline)/include -I$(brew --prefix sqlite3)/include -I$(brew --prefix zlib)/include"
export PKG_CONFIG_PATH="$(brew --prefix openssl)/lib/pkgconfig:$(brew --prefix readline)/lib/pkgconfig:$(brew --prefix sqlite3)/lib/pkgconfig"

# Persisting to .zshrc
append_env_var "sqlite/bin" 'export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"'
append_env_var "LDFLAGS.*openssl" "export LDFLAGS=\"$LDFLAGS\""
append_env_var "CPPFLAGS.*openssl" "export CPPFLAGS=\"$CPPFLAGS\""
append_env_var "PKG_CONFIG_PATH.*openssl" "export PKG_CONFIG_PATH=\"$PKG_CONFIG_PATH\""
