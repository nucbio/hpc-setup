-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - The XML C parser and toolkit of GNOME.

This module provides the libraries and headers for XML and HTML parsing.
It is a core dependency for:
- R 'XML', 'xml2', and 'tidyverse' packages
- Python 'lxml' and 'beautifulsoup4' libraries
- Bioinformatics tools parsing GFF3/GTF or XML reports
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Library/XML")
whatis("Description: libxml2 is the XML C parser and toolkit developed for the Gnome project.")
whatis("URL: https://gitlab.gnome.org/GNOME/libxml2")

-- libxml2 often links against zlib and lzma for compressed XML support
load("zlib/${ZLIB_VERSION}")
load("xz/${XZ_VERSION}")

local root = "${TOOL_PATH}"

-- Binaries (xmllint, xmlcatalog, xml2-config)
prepend_path("PATH",            pathJoin(root, "bin"))

-- Libraries
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "lib"))

-- Includes
-- Note: libxml2 usually puts headers in include/libxml2/libxml
prepend_path("CPATH",           pathJoin(root, "include"))
prepend_path("CPATH",           pathJoin(root, "include/libxml2"))

-- pkg-config (Essential for R and Python extensions)
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib/pkgconfig"))

----------------------------------------------------------------------
-- Developer & Tool Access Variables
----------------------------------------------------------------------
setenv("LIBXML2_ROOT", root)
setenv("XML2_CONFIG",  pathJoin(root, "bin/xml2-config"))

-- Specifically for R's 'xml2' package configuration
setenv("LIBXML_INCDIR", pathJoin(root, "include/libxml2"))
setenv("LIBXML_LIBDIR", pathJoin(root, "lib"))

-- Man pages
prepend_path("MANPATH", pathJoin(root, "share/man"))

conflict("${TOOL}")
