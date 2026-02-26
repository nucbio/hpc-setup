-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION}
High-performance JPEG codec.
This module sets include, library, and pkg-config paths for compiling software
against this installation.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: library")
whatis("Description: JPEG codec")
whatis("URL: https://libjpeg-turbo.org")

local root = "${TOOL_PATH}"
local bin = pathJoin(root, "bin")
local lib = pathJoin(root, "$LIB")
local pkgconf = pathJoin(root, "$PKG_CONF")
local include = pathJoin(root, "include")

prepend_path("PATH",             bin)
prepend_path("CPATH",            include)
prepend_path("LD_LIBRARY_PATH",  lib)
prepend_path("LIBRARY_PATH",     lib)
prepend_path("PKG_CONFIG_PATH",  pkgconf)

-- Build helper flags
prepend_path("CPPFLAGS", "-I" .. include, " ")
prepend_path("LDFLAGS",  "-L" .. lib, " ")

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end
