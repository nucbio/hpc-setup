-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - High-level programming language

This module provides the ${TOOL} interpreter and full standard library stack.
It automatically loads dependencies required for:
- SSL/TLS (pip, requests)
- Readline (interactive shell)
- Compression (lzma, bzip2, zlib)
- Terminal handling (ncurses)
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Programming Language")
whatis("Description: Python is an interpreted, interactive, object-oriented programming language.")

----------------------------------------------------------------------
-- Load the dependency stack
----------------------------------------------------------------------
load("openssl/${OPENSSL_VERSION}")
load("readline/${READLINE_VERSION}")
load("ncurses/${NCURSES_VERSION}")
load("xz/${XZ_VERSION}")
load("bzip2/${BZIP2_VERSION}")
load("libcurl/${LIBCURL_VERSION}")
load("sqlite/${SQLITE_VERSION}")

----------------------------------------------------------------------
-- Python installation paths
----------------------------------------------------------------------
local root = "${TOOL_PATH}"

-- Add Python and pip to PATH
prepend_path("PATH",            pathJoin(root, "bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "$LIB"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "$LIB"))
prepend_path("CPATH",           pathJoin(root, "include"))

-- pkg-config
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "$PKG_CONF"))

-- Python specific environment variables
setenv("PYTHONHOME", root)
-- Set PYTHONPATH to include site-packages for this specific version
local pyver = "${TOOL_VERSION:0:4}" -- Extracts "3.11" from "3.11.x"
prepend_path("PYTHONPATH", pathJoin(root, "lib/python" .. pyver .. "/site-packages"))

conflict("${TOOL}")
conflict("python")

if mode() == "load" then
    LmodMessage("Python ${TOOL_VERSION} loaded. Dependencies: OpenSSL, Readline, LZMA.")
end
