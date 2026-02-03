#!/bin/bash


# Make lua module file
# Usage: make_lua_module $TOOL $TOOL_VERSION
make_lua_module() {
    # Arguments
    local TOOL="$1"
    local TOOL_VERSION="$2"
    local TOOL_PATH="$3"  # Optional

    # Global/Environment variables check
    if [[ -z "$INSTALL_DIR" || -z "$REPO_DIR" ]]; then
        echo "Error: INSTALL_DIR or REPO_DIR is not defined."
        return 1
    fi

    # Basic validation for required fields
    if [[ -z "$TOOL" || -z "$TOOL_VERSION" ]]; then
        echo "Error: usage: make_lua_module <TOOL> <TOOL_VERSION> [OPTIONAL_TOOL_PATH]"
        return 1
    fi

    # Define TOOL_PATH if not provided via $3
    if [[ -z "$TOOL_PATH" ]]; then
        TOOL_PATH="$INSTALL_DIR/$TOOL/$TOOL-$TOOL_VERSION"
    fi

    local TEMPLATE="$REPO_DIR/modules/templates/$TOOL.lua"
    local MODULE_DIR="$INSTALL_DIR/modulefiles/$TOOL"
    local OUTPUT_FILE="$MODULE_DIR/$TOOL_VERSION.lua"

    # Check if template exists
    if [[ ! -f "$TEMPLATE" ]]; then
        echo "Template not found for $TOOL. Minimal template will be used."
        TEMPLATE="$TEMPLATE_DIR/minimal.lua"
    fi

    mkdir -p "$MODULE_DIR"

    # Export variables for envsubst
    export TOOL TOOL_VERSION TOOL_PATH

    # Generate the file using the template
    envsubst < "$TEMPLATE" > "$OUTPUT_FILE"

    echo "Module for $TOOL created."
}
