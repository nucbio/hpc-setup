-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - GNU Internationalization (i18n) utilities.

This module provides the headers, libraries, and tools (msgfmt, xgettext) 
required for multilingual support in R, Python, and Gtk-based libraries.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Library/Development")
whatis("Description: GNU gettext offers a framework to help other GNU packages produce multi-lingual messages.")
whatis("URL: https://www.gnu.org/software/gettext/")

-- gettext often benefits from having your Core icons available
load("ncurses/${NCURSES_VERSION}")

local root = "$TOOL_PATH"

-- Binaries (envsubst, gettext, msgfmt, xgettext, etc.)
prepend_path("PATH",            pathJoin(root, "bin"))

-- Libraries
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "$LIB"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "$LIB"))

-- Includes
prepend_path("CPATH",           pathJoin(root, "include"))

-- pkg-config
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "$PKG_CONF"))

-- Environment variables for Autotools and R
setenv("GETTEXT_ROOT", root)
-- Some R configurations look specifically for the .h location
setenv("GETTEXT_INCLUDE_DIR", pathJoin(root, "include"))

conflict("${TOOL}")
