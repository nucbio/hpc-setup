-- ${TOOL} version ${TOOL_VERSION}

-- Define Lua variables from template placeholders
local tool_name = "${TOOL}"
local tool_ver  = "${TOOL_VERSION}"
local root      = "${TOOL_PATH}"

whatis(tool_name .. " " .. tool_ver .. " installed locally without sudo")

help([[
Provides the ]] .. tool_name .. [[ toolchain and Cargo installed in a custom directory.
]])

-- Root paths
local cargo_home  = pathJoin(root, "cargo")
local rustup_home = pathJoin(root, "rustup")

-- Environment variables
setenv("CARGO_HOME",  cargo_home)
setenv("RUSTUP_HOME", rustup_home)

-- Add Cargo bin directory
prepend_path("PATH", pathJoin(cargo_home, "bin"))

-- Rust libraries (Cargo folder)
prepend_path("LD_LIBRARY_PATH", pathJoin(cargo_home, "$LIB"))

-- Rust libraries (Toolchain specific folder)
local toolchain_path = pathJoin(rustup_home, "toolchains", tool_ver .. "-x86_64-unknown-linux-gnu")
prepend_path("LD_LIBRARY_PATH", pathJoin(toolchain_path, "$LIB"))

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end
