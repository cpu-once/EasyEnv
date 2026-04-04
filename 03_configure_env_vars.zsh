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
# ---------------------------------------------------------
# 0. ASDF Core Configuration (Added for pnpm/shim resolution)
# ---------------------------------------------------------
# Homebrew 설치 경로를 기반으로 asdf.sh 위치 파악
if command -v brew >/dev/null; then
    ASDF_SH_PATH="$(brew --prefix asdf)/libexec/asdf.sh"
    
    if [[ -f "$ASDF_SH_PATH" ]]; then
        # 1) .zshrc에 영구 기록 (중복 방지)
        append_env_var "asdf.sh" ". $ASDF_SH_PATH"
        
        # 2) 현재 설치 세션에 즉시 로드 (Phase 4, 5, 6에서 asdf 명령어를 쓰기 위함)
        . "$ASDF_SH_PATH"
        echo "   ✅ asdf core sourced and persisted."
    else
        echo "   ❌ ERROR: asdf.sh not found at $ASDF_SH_PATH"
    fi
fi

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
