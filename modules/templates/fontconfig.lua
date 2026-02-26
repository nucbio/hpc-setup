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

-- Dependencies
load("libexpat/${EXPAT_VERSION}")
load("freetype/${FREETYPE_VERSION}")

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

setenv("FONTCONFIG_PATH", pathJoin(root, "etc/fonts"))
setenv("FONTCONFIG_FILE", pathJoin(root, "etc/fonts/fonts.conf"))
prepend_path("XDG_DATA_DIRS", pathJoin(root, "share"))

-- Developer Access Variables
setenv("FONTCONFIG_ROOT", root)

conflict("${TOOL}")

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end
