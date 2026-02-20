-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - The XML C parser and toolkit.

This module provides the libraries and headers for XML and HTML parsing.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Core")
whatis("Description: libxml2 is the XML C parser and toolkit.")
whatis("URL: https://gitlab.gnome.org/GNOME/libxml2")

-- Dependencies
load("zlib/${ZLIB_VERSION}")
load("xz/${XZ_VERSION}")

local root = "${TOOL_PATH}"
local bin = pathJoin(root, "bin")
local lib = pathJoin(root, "$LIB")
local include = pathJoin(root, "include/libxml2") 
local pkgconf = pathJoin(root, "$PKG_CONF")

prepend_path("PATH",             bin)
prepend_path("PKG_CONFIG_PATH",  pkgconf)
prepend_path("LD_LIBRARY_PATH",  lib)
prepend_path("LIBRARY_PATH",     pathJoin(root, "$LIB"))
prepend_path("CPATH",            include)
--prepend_path("LDFLAGS",  "-L" .. lib, " ")
--prepend_path("CPPFLAGS", "-I" .. include, " ")
--prepend_path("CFLAGS",   "-I" .. include, " ")
--prepend_path("CXXFLAGS", "-I" .. include, " ")

-- Variables
--setenv("LIBXML2_ROOT", root)
setenv("LIBXML_INCDIR", include)
setenv("LIBXML_LIBDIR", lib)

conflict("${TOOL}")
