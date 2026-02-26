-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - Free software emulation of curses.
Used for text-based user interfaces (TUI).
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")

local root = "${TOOL_PATH}"

prepend_path("PATH",             pathJoin(root, "bin"))
prepend_path("PKG_CONFIG_PATH",  pathJoin(root, "$PKG_CONF"))
prepend_path("LD_LIBRARY_PATH",  pathJoin(root, "$LIB"))
prepend_path("LIBRARY_PATH",     pathJoin(root, "$LIB"))
prepend_path("LDFLAGS", "-L" ..  pathJoin(root, "lib"), " ")
prepend_path("CPPFLAGS", "-I" .. pathJoin(root, "include"), " ")

prepend_path("CPATH",            pathJoin(root, "include"))
prepend_path("CPATH",            pathJoin(root, "include/ncurses"))

setenv("NCURSES_HOME", root)

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end
