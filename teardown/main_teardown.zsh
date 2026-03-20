#!/usr/bin/env zsh

# Enforce fail-fast mechanism: exit immediately if any pipeline or sub-script fails.
set -e

# Dynamically resolve the absolute directory of this script
SCRIPT_DIR="${0:A:h}"

echo "============================================================"
echo "🚀 Initiating Master Teardown Sequence for ASDF..."
echo "============================================================"
echo ""

# Execute Phase 1: Gracefully uninstall language runtimes
zsh "$SCRIPT_DIR/01_teardown_runtimes.zsh"

# Execute Phase 2: Remove runtime routing plugins
zsh "$SCRIPT_DIR/02_teardown_plugin.zsh"

# Execute Phase 3: Sanitize shell environment variables
zsh "$SCRIPT_DIR/03_clean_env_vars.zsh"

# Execute Phase 4: Purge compilation dependencies (Homebrew)
zsh "$SCRIPT_DIR/04_remove_system_deps.zsh"

# Execute Phase 5: Destroy user-space isolation core
zsh "$SCRIPT_DIR/05_purge_asdf_core.zsh"

echo ""
echo "============================================================"
echo "⚙️  Executing Final System Validations..."
echo "============================================================"

# Execute Phase 6: Post-Teardown Negative Assertions
# We turn off 'set -e' temporarily here just in case the validation script 
# returns a non-zero exit code, allowing us to handle the output gracefully.
set +e
zsh "$SCRIPT_DIR/06_validate_teardown.zsh"
VALIDATION_EXIT_CODE=$?
set -e

echo ""
echo "============================================================"
if [[ $VALIDATION_EXIT_CODE -eq 0 ]]; then
    echo "🎉 SUCCESS: Teardown complete. Your environment is clean."
    echo "💡 IMPORTANT: Run 'exec zsh' to flush your current shell's memory state."
else
    echo "⚠️  WARNING: Teardown finished, but validation caught ghost states."
    echo "💡 Please review the errors above. You may need to run 'exec zsh' and test again."
    exit $VALIDATION_EXIT_CODE
fi
echo "============================================================"
