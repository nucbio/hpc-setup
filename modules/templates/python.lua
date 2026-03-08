-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION}
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")

-- Load the dependency stack
load("openssl/${OPENSSL_VERSION}")
load("readline/${READLINE_VERSION}")
load("ncurses/${NCURSES_VERSION}")
load("xz/${XZ_VERSION}")
load("bzip2/${BZIP2_VERSION}")
load("libcurl/${LIBCURL_VERSION}")
load("sqlite3/${SQLITE_VERSION}")

-- Python installation paths
local root = "${TOOL_PATH}"

-- Add Python and pip to PATH
prepend_path("PATH",            pathJoin(root, "bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "$LIB"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "$LIB"))
prepend_path("CPATH",           pathJoin(root, "include"))

-- pkg-config
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "$PKG_CONF"))

-- Python specific environment variables
-- setenv("PYTHONHOME", root)
-- Set PYTHONPATH to include site-packages for this specific version
--local pyver = "${TOOL_VERSION:0:4}" -- Extracts "3.11" from "3.11.x"
--prepend_path("PYTHONPATH", pathJoin(root, "lib/python" .. pyver .. "/site-packages"))

conflict("${TOOL}")
conflict("python")

if mode() == "load" then
    LmodMessage("Loading python ${TOOL_VERSION}.")
end

