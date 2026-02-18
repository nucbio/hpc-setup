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

local bin = pathJoin(root, "bin")
local lib = pathJoin(root, "$LIB")
local include = pathJoin(root, "include")
local pkg_conf = pathJoin(root, "$PKG_CONF")

-- Variables
prepend_path("PATH",            bin)
prepend_path("LD_LIBRARY_PATH", lib)
prepend_path("LIBRARY_PATH",    lib)
prepend_path("CPATH",           include)
prepend_path("PKG_CONFIG_PATH", pkg_conf)

setenv("GETTEXT_ROOT", root)
setenv("GETTEXT_INCLUDE_DIR", include)

conflict("${TOOL}")
