#!/bin/bash

# Script to generate Lua module files for Environment Modules
# Usage: ./generate_module.sh <TOOL> <TOOL_VERSION> <TOOL_PATH>

# Check if correct number of arguments provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <TOOL> <TOOL_VERSION> <TOOL_PATH>"
    exit 1
fi

# Assign arguments to variables
TOOL="$1"
TOOL_VERSION="$2"
TOOL_PATH="$3"

# Create the module directory if it doesn't exist
MODULE_DIR="$INSTALL_DIR/modulefiles/$TOOL"
mkdir -p "$MODULE_DIR"
OUTPUT_FILE="$MODULE_DIR/$TOOL_VERSION.lua"

# Generate the Lua module file
cat > "$OUTPUT_FILE" << EOF
-- $TOOL version $TOOL_VERSION
whatis("$TOOL version $TOOL_VERSION")
prepend_path("PATH", "$TOOL_PATH")
EOF
