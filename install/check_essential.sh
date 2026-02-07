#!/bin/bash

# Verifies all required dependencies.

echo "Checking system dependencies..."
echo "-----------------------------------------------"

DEPENDENCIES="gcc g++ make cmake install tar gzip bzip2 xz"
MISSING_COUNT=0

for tool in $DEPENDENCIES; do
    if command -v "$tool" >/dev/null 2>&1; then
        echo "[OK] Found: $tool"
    else
        echo "[FAIL] Missing: $tool"
        MISSING_COUNT=$((MISSING_COUNT + 1))
    fi
done

echo "-----------------------------------------------"

# This prevents closing the user's terminal session.
safe_exit() {
    [ "$1" -eq 0 ] && _msg="SUCCESS" || _msg="FAILURE"
    echo "Result: $_msg"
    
    # Check if script is being sourced
    if [ "$0" != "$BASH_SOURCE" ] && [ -n "$BASH_SOURCE" ] || [ "$0" != "$3" ] 2>/dev/null; then
        return "$1"
    else
        exit "$1"
    fi
}

if [ "$MISSING_COUNT" -ne 0 ]; then
    echo "Error: $MISSING_COUNT tool(s) missing."
    safe_exit 1
else
    safe_exit 0
fi
