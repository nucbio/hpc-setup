-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} - Portable Network Graphics library
Version: ${TOOL_VERSION}
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: library")
whatis("Description: PNG reference library")
whatis("URL: http://www.libpng.org/pub/png/libpng.html")

local root = "${TOOL_PATH}"

-- Prepend to PATH for binaries
prepend_path("PATH", pathJoin(root, "bin"))

-- Prepend to library paths
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "$LIB"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "$LIB"))

-- Build helper flags
setenv("CPPFLAGS", "-I" .. pathJoin(root, "include"))
setenv("LDFLAGS",  "-L" .. pathJoin(root, "$LIB"))

-- Prepend to include path
prepend_path("CPATH",              pathJoin(root, "include"))
prepend_path("CPLUS_INCLUDE_PATH", pathJoin(root, "include"))

-- PKG_CONFIG_PATH for pkg-config
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "$PKG_CONF"))

-- Set LIBPNG environment variables
setenv("LIBPNG_ROOT", root)
setenv("LIBPNG_DIR",  root)
setenv("LIBPNG_HOME", root)

-- Specific paths that R might look for
setenv("LIBPNG_INCLUDE", pathJoin(root, "include"))
setenv("LIBPNG_LIB",     pathJoin(root, "$LIB"))

-- Add man pages
prepend_path("MANPATH", pathJoin(root, "share/man"))
