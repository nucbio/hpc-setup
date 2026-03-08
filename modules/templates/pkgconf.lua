-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - A helper tool used when compiling applications and libraries.
pkg-config is a system for managing library compile and link flags that works 
with automake and autoconf.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Development/Tools")
whatis("Description: pkg-config is a helper tool for compiling applications and libraries.")
whatis("URL: https://www.freedesktop.org/wiki/Software/pkg-config/")

local root = "${TOOL_PATH}"

-- Binaries
prepend_path("PATH", pathJoin(root, "bin"))

-- PKG_CONFIG_PATH is the primary search path for .pc files
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "$PKG_CONF"))
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "share/pkgconfig"))

-- Include directories (if pkg-config has header files)
prepend_path("CPATH", pathJoin(root, "include"))

-- Environment variables for pkg-config itself
setenv("PKG_CONFIG", pathJoin(root, "bin/pkg-config"))
setenv("PKG_CONFIG_TOP_BUILD_DIR", root)

-- Man pages
prepend_path("MANPATH", pathJoin(root, "share/man"))

-- Aclocal path for m4 macros (useful for autotools integration)
prepend_path("ACLOCAL_PATH", pathJoin(root, "share/aclocal"))

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end
