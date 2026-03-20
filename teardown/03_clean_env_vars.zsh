#!/usr/bin/env zsh
set -e

echo "🧹 Phase 3: Sanitizing shell environment variables..."

ZSHRC_FILE="$HOME/.zshrc"

if [[ -f "$ZSHRC_FILE" ]]; then
  echo "Performing surgical extraction of compiler linkage from $ZSHRC_FILE ..."

  # macOS strictly requires the backup extension format (-i '.bak') for sed 
  sed -i '.bak' '/set-java-home.zsh/d' "$ZSHRC_FILE"
  sed -i '.bak' '/sqlite\/bin/d' "$ZSHRC_FILE"
  sed -i '.bak' '/LDFLAGS.*openssl/d' "$ZSHRC_FILE"
  sed -i '.bak' '/CPPFLAGS.*openssl/d' "$ZSHRC_FILE"
  sed -i '.bak' '/PKG_CONFIG_PATH.*openssl/d' "$ZSHRC_FILE"
  sed -i '.bak' '/libexec\/asdf.sh/d' "$ZSHRC_FILE"

  echo "✅ Memory state configurations removed. Backup preserved at ${ZSHRC_FILE}.bak"
else
  echo "⚠️ No ~/.zshrc file found to sanitize."
fi
