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

prepend_path("PATH",             pathJoin(root, "bin"))
prepend_path("PKG_CONFIG_PATH",  pathJoin(root, "$PKG_CONF"))

prepend_path("LD_LIBRARY_PATH",  pathJoin(root, "$LIB"))
prepend_path("LIBRARY_PATH",     pathJoin(root, "$LIB"))
prepend_path("CPATH",            pathJoin(root, "include"))
prepend_path("CPATH",            pathJoin(root, "include/libxml2/libxml"))
prepend_path("CPPFLAGS", "-I" .. pathJoin(root, "include"), " ")
prepend_path("LDFLAGS",  "-L" .. pathJoin(root, "$LIB"),   " ")

-- Variables
setenv("LIBXML2_ROOT", root)
setenv("XML2_CONFIG",  pathJoin(root, "bin/xml2-config"))

setenv("LIBXML_INCDIR", pathJoin(root, "include/libxml2"))
setenv("LIBXML_LIBDIR", pathJoin(root, "$LIB"))

conflict("${TOOL}")
