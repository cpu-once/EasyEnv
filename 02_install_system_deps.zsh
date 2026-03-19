#!/usr/bin/env zsh
set -e

echo "📦 Phase 2: Resolving system dependencies (Homebrew)..."

# Required for Python C-extension compilation (ssl, sqlite, zlib)
brew install openssl readline sqlite3 xz zlib tcl-tk
