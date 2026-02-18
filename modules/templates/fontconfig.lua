-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - Library for configuring and customizing font access.
It allows software to find, font-match, and render text.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Library/Graphics")
whatis("Description: Fontconfig is a library for configuring and customizing font access.")
whatis("URL: https://www.freedesktop.org/wiki/Software/fontconfig/")

-- Fontconfig depends on Expat (XML parsing) and FreeType
load("libexpat/${EXPAT_VERSION}")
load("freetype/${FREETYPE_VERSION}")

local root = "${TOOL_PATH}"

-- Binaries (fc-cache, fc-list, fc-match, etc.)
prepend_path("PATH",            pathJoin(root, "bin"))

-- Libraries
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "$LIB"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "$LIB"))

-- Includes
prepend_path("CPATH",           pathJoin(root, "include"))

-- pkg-config (Crucial for Cairo and HarfBuzz builds)
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib/pkgconfig"))

----------------------------------------------------------------------
-- Fontconfig Specific Configuration
----------------------------------------------------------------------
-- Tells fontconfig where to find the 'fonts.conf' file
setenv("FONTCONFIG_PATH", pathJoin(root, "etc/fonts"))
setenv("FONTCONFIG_FILE", pathJoin(root, "etc/fonts/fonts.conf"))

-- Helps fontconfig find data files in your custom prefix
prepend_path("XDG_DATA_DIRS", pathJoin(root, "share"))

-- Developer Access Variables
setenv("FONTCONFIG_ROOT", root)

conflict("${TOOL}")
