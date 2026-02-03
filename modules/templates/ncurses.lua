-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - Free software emulation of curses.
Used for text-based user interfaces (TUI).
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")

local root = "${TOOL_PATH}"

prepend_path("PATH",            pathJoin(root, "bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "lib"))

-- Ncurses often needs the include/ncurses path specifically
prepend_path("CPATH",           pathJoin(root, "include"))
prepend_path("CPATH",           pathJoin(root, "include/ncurses"))

prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib/pkgconfig"))
setenv("NCURSES_HOME", root)
