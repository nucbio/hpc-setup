-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - Self-contained, serverless, SQL database engine.

This module provides the headers and libraries for ${TOOL}. 
It is a required dependency for the Python 'sqlite3' standard library module
and various R 'RSQLite' packages.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Database/Library")
whatis("Description: SQLite is a C-language library that implements a small, fast, self-contained, high-reliability, full-featured, SQL database engine.")
whatis("URL: https://www.sqlite.org/")

local root = "${TOOL_PATH}"

-- Binaries
prepend_path("PATH",            pathJoin(root, "bin"))

-- Libraries
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "lib"))

-- Includes
prepend_path("CPATH",           pathJoin(root, "include"))

-- pkg-config
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib/pkgconfig"))

-- Variables for high-level language configures
setenv("SQLITE_ROOT", root)
setenv("SQLITE_INCLUDE_DIR", pathJoin(root, "include"))
setenv("SQLITE_LIBS", "-L" .. pathJoin(root, "lib") .. " -lsqlite3")
