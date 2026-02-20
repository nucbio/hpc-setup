-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - Library for reading and writing TIFF files.

This module provides the libraries and headers for TIFF image support.
It is a required dependency for:
- R 'tiff' and 'magick' packages
- Python 'Pillow' (PIL) and 'opencv' libraries
- Cairo graphics backend (for high-quality TIFF output)

Built with support for Zlib, Jpeg, and LZMA compression.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Library/Graphics")
whatis("Description: libtiff provides support for the Tagged Image File Format (TIFF), a widely used format for storing image data.")
whatis("URL: http://libtiff.maptools.org/")

-- Dependencies
load("zlib/${ZLIB_VERSION}")
load("libjpeg/${LIBJPEG_VERSION}")
load("xz/${XZ_VERSION}")

local root = "${TOOL_PATH}"

-- Binaries (tiffcp, tiffdump, tiffinfo, etc.)
prepend_path("PATH",            pathJoin(root, "bin"))

-- Libraries
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "$LIB"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "$LIB"))

-- Includes
prepend_path("CPATH",           pathJoin(root, "include"))

-- pkg-config
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "$PKG_CONF"))

setenv("LIBTIFF_ROOT", root)
setenv("TIFF_INCLUDE_DIR", pathJoin(root, "include"))
setenv("TIFF_LIBRARY",     pathJoin(root, "$LIB"))

-- Man pages
prepend_path("MANPATH", pathJoin(root, "share/man"))

conflict("${TOOL}")
