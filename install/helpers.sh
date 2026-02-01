# Get last release version from github repo
# repo format: owner_name/repo_name
get_latest_github_release() {
    local repo=$1
    # 1. Fetch JSON from API
    # 2. Look for "tag_name"
    # 3. Strip everything except numbers and dots (handles 'v1.2' -> '1.2')
    wget -qO- "https://api.github.com/repos/${repo}/releases/latest" | \
    grep -Po '"tag_name":\s*"\K[^"]*' | \
    sed 's/^v//'
}

# Function to generate Lua module files for Environment Modules
# Usage: make_lua_module <TOOL> <TOOL_VERSION> <TOOL_PATH>
make_lua_module() {
    local TOOL="$1"
    local TOOL_VERSION="$2"
    local TOOL_PATH="$3"

    # Check for missing arguments
    if [[ -z "$TOOL" || -z "$TOOL_VERSION" || -z "$TOOL_PATH" ]]; then
        echo "Error: make_lua_module requires <TOOL> <TOOL_VERSION> <TOOL_PATH>"
        return 1
    fi

    # Ensure INSTALL_DIR is set (crucial for non-sudo setups)
    if [[ -z "$INSTALL_DIR" ]]; then
        echo "Error: INSTALL_DIR environment variable is not defined."
        return 1
    fi

    local MODULE_DIR="$INSTALL_DIR/modulefiles/$TOOL"
    local OUTPUT_FILE="$MODULE_DIR/$TOOL_VERSION.lua"

    mkdir -p "$MODULE_DIR"

    # Generate the Lua module file
    cat > "$OUTPUT_FILE" << EOF
-- $TOOL version $TOOL_VERSION
help([[Sets up $TOOL version $TOOL_VERSION]])
whatis("Name: $TOOL")
whatis("Version: $TOOL_VERSION")
whatis("Description: $TOOL installation via hpc-setup")

prepend_path("PATH", "$TOOL_PATH")
EOF

    echo "Module created at: $OUTPUT_FILE"
}
