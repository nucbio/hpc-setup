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
        TEMPLATE="$REPO_DIR/modules/templates/minimal.lua"
    fi

    mkdir -p "$MODULE_DIR"

    # Find library and pkg-config exists
    LIB_PATH=$(find "$TOOL_PATH" -maxdepth 1 -type d \( -name "lib" -o -name "lib64" \) -print -quit)
    PKG_CONF_PATH=$(find "$TOOL_PATH" -type d -name "pkgconfig" -print -quit)

    if [ -n "$LIB_PATH" ]; then
        export LIB=${LIB_PATH#$TOOL_PATH/}
    else
        export LIB="lib"  # Default
    fi

    if [ -n "$PKG_CONF_PATH" ]; then
        export PKG_CONF=${PKG_CONF_PATH#$TOOL_PATH/}
    else
        export PKG_CONF="lib/pkgconfig" # Default
    fi
    #TODO make conditinal block in lua tempates instead of defaults for not existing directory

    # Export variables for envsubst
    export TOOL TOOL_VERSION TOOL_PATH

    # Generate the file using the template
    envsubst < "$TEMPLATE" > "$OUTPUT_FILE"

    echo "Module for $TOOL created."
}
