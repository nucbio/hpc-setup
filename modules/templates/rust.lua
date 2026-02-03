-- ${TOOL} version ${TOOL_VERSION}

whatis("${TOOL} ${TOOL_VERSION} installed locally without sudo")

help([[
Provides the ${TOOL} toolchain and Cargo installed in a custom directory.

This module sets all environment variables required for:
- rustup
- rustc
- cargo
- rustfmt
- clippy
]])

-----------------------------------------------------------------------
-- Root paths
-----------------------------------------------------------------------
local root = "${TOOL_PATH}"

local cargo_home  = pathJoin(root, "cargo")
local rustup_home = pathJoin(root, "rustup")

-----------------------------------------------------------------------
-- Environment variables
-----------------------------------------------------------------------
setenv("CARGO_HOME",  cargo_home)
setenv("RUSTUP_HOME", rustup_home)

-- Add Cargo bin directory (contains rustc, cargo, rustup)
prepend_path("PATH", pathJoin(cargo_home, "bin"))

-- Rust libraries
prepend_path("LD_LIBRARY_PATH", pathJoin(cargo_home, "lib"))
-- Note: The toolchain path is often static even across versions, 
-- but kept here as part of the Rust ecosystem setup.
prepend_path("LD_LIBRARY_PATH", pathJoin(rustup_home, "toolchains/stable-x86_64-unknown-linux-gnu/lib"))

-- Handle Libraries
-- Note: Rust often bundles its own LLVM and dynamic libs. 
-- We use a wildcard/variable approach for the toolchain path to ensure it finds the specific version installed.
local toolchain_path = pathJoin(rustup_home, "toolchains", tool_ver .. "-x86_64-unknown-linux-gnu")
prepend_path("LD_LIBRARY_PATH", pathJoin(toolchain_path, "lib"))
