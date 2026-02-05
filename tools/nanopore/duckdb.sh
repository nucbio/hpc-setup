#!/bin/bash

echo "Install DuckDB"

# Variables
TOOL_NAME="duckdb"
export DUCKDB_VERSION="1.1.3"  # Adjust to the current latest version
SOURCE_URL="https://github.com/duckdb/duckdb/releases/download/v${DUCKDB_VERSION}/duckdb_cli-linux-amd64.zip"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$DUCKDB_VERSION"
SOURCE_ARCHIVE="$INSTALL_DIR/sources"

# 1. Prepare Environment
mkdir -p "$SOURCE_ARCHIVE"
rm -rf /tmp/$TOOL_NAME-build
mkdir -p /tmp/$TOOL_NAME-build
cd /tmp/$TOOL_NAME-build

# 2. Download and Archive
wget -qL "$SOURCE_URL" -O "${TOOL_NAME}_cli-${DUCKDB_VERSION}-linux-amd64.zip"
cp "${TOOL_NAME}_cli-${DUCKDB_VERSION}-linux-amd64.zip" "$SOURCE_ARCHIVE/"

# 3. Unpack and Install
# Create a bin directory as is standard for CLI-only tools
mkdir -p "$TARGET_DIR/bin"
unzip -q "${TOOL_NAME}_cli-${DUCKDB_VERSION}-linux-amd64.zip" -d "$TARGET_DIR/bin"

# 4. Cleanup Build Area
rm -rf /tmp/$TOOL_NAME-build

# 5. Module generation
make_lua_module "duckdb" "$DUCKDB_VERSION"
