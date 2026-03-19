#!/usr/bin/env zsh

# We do not use 'set -e' here. A test runner must evaluate all assertions 
# and aggregate failures, rather than terminating at the first failing assertion.

SCRIPT_DIR="${0:A:h}"
CONFIG_FILE="$SCRIPT_DIR/.tool-versions"

echo "🧪 Phase 6: Executing Post-Installation Integration Tests..."

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "❌ TEST ABORTED: Configuration file '$CONFIG_FILE' is missing."
    exit 1
fi

# Zsh associative arrays mapping asdf plugins to their primary CLI binaries
typeset -A binary_map=(
    [nodejs]="node"
    [java]="java"
    [python]="python"
    [rust]="rustc"
    [golang]="go"
)

# Zsh associative array mapping binaries to their respective version flags
typeset -A flag_map=(
    [node]="-v"
    [java]="-version"
    [python]="--version"
    [rustc]="--version"
    [go]="version"
)

local errors=0

# Process the configuration file, ignoring comments and empty lines
awk '/^[^# \t]/ {print $1, $2}' "$CONFIG_FILE" | while read -r plugin expected_version; do
    echo "----------------------------------------"
    echo "🔍 Validating sub-system: $plugin"
    
    local cmd="${binary_map[$plugin]}"
    local flag="${flag_map[$cmd]}"

    # Assertion 1: Shim Resolution Verification
    local resolved_path=$(command -v "$cmd" || true)
    if [[ -z "$resolved_path" ]]; then
        echo "   ❌ FATAL: Binary '$cmd' not found in PATH."
        ((errors++))
        continue
    fi

    if [[ "$resolved_path" != *".asdf/shims/"* ]]; then
        echo "   ⚠️ WARNING: '$cmd' is resolving to system binary ($resolved_path) instead of asdf shim."
        ((errors++))
    else
        echo "   ✅ Path integrity verified: $resolved_path"
    fi

    # Assertion 2: Execution and Dynamic Linking Verification
    # We redirect stderr to stdout because tools like Java print version info to stderr.
    local execution_output
    if ! execution_output=$("$cmd" $flag 2>&1); then
        echo "   ❌ FATAL: '$cmd $flag' execution failed. Possible dynamic linking or architecture mismatch."
        echo "      Output: $execution_output"
        ((errors++))
        continue
    fi
    
    # We extract the first line of the output to keep the log clean
    local version_summary=$(echo "$execution_output" | head -n 1)
    echo "   ✅ Execution verified: $version_summary"

    # Assertion 3: asdf State Verification
    local current_asdf_version=$(asdf current "$plugin" | awk '{print $2}')
    echo "   ✅ asdf state maps '$plugin' to version '$current_asdf_version'"
done

echo "----------------------------------------"
if [[ $errors -gt 0 ]]; then
    echo "🚨 Validation Complete: $errors assertion(s) failed."
    echo "Review the logs above. Ensure you have restarted your terminal or sourced ~/.zshrc."
    exit 1
else
    echo "🎯 Validation Complete: All systems nominal. The environment is production-ready."
    exit 0
fi
