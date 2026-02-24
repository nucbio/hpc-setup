# Simple module for pip tools which are in python directory
make_pip_module() {
    # Arguments
    local TOOL="$1"
    local TOOL_VERSION="$2"

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

    local TEMPLATE="$REPO_DIR/modules/templates/$TOOL.lua"
    local MODULE_DIR="$INSTALL_DIR/modulefiles/$TOOL"
    local OUTPUT_FILE="$MODULE_DIR/$TOOL_VERSION.lua"

    # Check if template exists
    if [[ ! -f "$TEMPLATE" ]]; then
        echo "Template not found for $TOOL. Minimal template will be used."
        TEMPLATE="$REPO_DIR/modules/templates/py_common.lua"
    fi

    mkdir -p "$MODULE_DIR"

    # Export variables for envsubst
    export TOOL TOOL_VERSION

    # Generate the file using the template
    envsubst < "$TEMPLATE" > "$OUTPUT_FILE"

    echo "Module for $TOOL created."
}
