#!/usr/bin/env zsh

echo "🧪 Phase 6: Executing Post-Teardown Negative Assertions..."

local errors=0

# Assertion 1: Core manager should not exist
if command -v asdf &>/dev/null; then
    echo "   ❌ FATAL: 'asdf' command is still resolvable in PATH."
    ((errors++))
else
    echo "   ✅ Core runtime manager 'asdf' successfully eradicated."
fi

# Assertion 2: Shim execution directories must be wiped
if echo "$PATH" | grep -q "\.asdf/shims"; then
    echo "   ❌ FATAL: '.asdf/shims' is still lingering in the current session's memory \$PATH."
    ((errors++))
else
    echo "   ✅ PATH integrity successfully decoupled from shims."
fi

# Assertion 3: Java Home context must be unbound
if [[ -n "$JAVA_HOME" && "$JAVA_HOME" == *".asdf"* ]]; then
    echo "   ❌ FATAL: \$JAVA_HOME is still pointing to the destroyed asdf directory."
    ((errors++))
else
    echo "   ✅ JVM Context safely decoupled."
fi

echo "----------------------------------------"
if [[ $errors -gt 0 ]]; then
    echo "🚨 Teardown Validation Complete: $errors assertion(s) failed."
    echo "The current shell session is holding ghost state. Execute 'exec zsh' to flush memory."
    exit 1
else
    echo "🎯 Teardown Validation Complete: Absolute baseline achieved. The machine is completely sterilized."
    exit 0
fi
