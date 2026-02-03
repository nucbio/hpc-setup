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

local base = "${TOOL_PATH}"

-- Prepend to PATH for binaries
prepend_path("PATH", pathJoin(base, "bin"))

-- Prepend to library paths
prepend_path("LD_LIBRARY_PATH", pathJoin(base, "lib"))
prepend_path("LIBRARY_PATH",    pathJoin(base, "lib"))

-- Prepend to include path
prepend_path("CPATH",              pathJoin(base, "include"))
prepend_path("CPLUS_INCLUDE_PATH", pathJoin(base, "include"))

-- PKG_CONFIG_PATH for pkg-config
prepend_path("PKG_CONFIG_PATH", pathJoin(base, "lib/pkgconfig"))

-- Set LIBPNG environment variables
setenv("LIBPNG_ROOT", base)
setenv("LIBPNG_DIR",  base)
setenv("LIBPNG_HOME", base)

-- Specific paths that R might look for
setenv("LIBPNG_INCLUDE", pathJoin(base, "include"))
setenv("LIBPNG_LIB",     pathJoin(base, "lib"))

-- Add man pages
prepend_path("MANPATH", pathJoin(base, "share/man"))
