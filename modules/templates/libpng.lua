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
local bin = pathJoin(root, "bin")
local lib = pathJoin(root, "$LIB")
local include = pathJoin(root, "include")
local pkgconf = pathJoin(root, "$PKG_CONF")
local man = pathJoin(root, "share/man")

-- Prepend to PATH for binaries
prepend_path("PATH", bin)

-- Prepend to library paths
prepend_path("LD_LIBRARY_PATH", lib)
prepend_path("LIBRARY_PATH",    lib)

-- Build helper flags
prepend_path("CPPFLAGS", "-I" .. include, " ")
prepend_path("LDFLAGS",  "-L" .. lib, " ")

-- Prepend to include path
prepend_path("CPATH",              include)
prepend_path("CPLUS_INCLUDE_PATH", include)

-- PKG_CONFIG_PATH for pkg-config
prepend_path("PKG_CONFIG_PATH",    pkgconf)

-- Set LIBPNG environment variables
setenv("LIBPNG_ROOT", root)
setenv("LIBPNG_DIR",  root)
setenv("LIBPNG_HOME", root)

-- Specific paths that R might look for
setenv("LIBPNG_INCLUDE", include)
setenv("LIBPNG_LIB",     lib)

-- Add man pages
prepend_path("MANPATH", man)

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end
