-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - A powerful, efficient, lightweight, embeddable scripting language.

This module provides the ${TOOL} interpreter and compiler used by Lmod 
and other scripting utilities in the stack.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Programming Language")
whatis("Description: Lua is a powerful, efficient, lightweight, embeddable scripting language.")
whatis("URL: https://www.lua.org/")

-- Lua usually depends on Readline and Ncurses for its interactive shell
load("readline/${READLINE_VERSION}")
load("ncurses/${NCURSES_VERSION}")

local root = "${TOOL_PATH}"

-- Binaries (lua, luac)
prepend_path("PATH",            pathJoin(root, "bin"))

-- Libraries
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "lib"))

-- Includes
prepend_path("CPATH",           pathJoin(root, "include"))

-- Man pages
prepend_path("MANPATH", pathJoin(root, "share/man"))

-- Lua specific package paths (where it looks for .lua and .so files)
local luaver = "${TOOL_VERSION:0:3}" -- Extracts "5.4" from "5.4.x"
setenv("LUA_PATH",  pathJoin(root, "share/lua", luaver, "?.lua") .. ";;")
setenv("LUA_CPATH", pathJoin(root, "lib/lua", luaver, "?.so") .. ";;")

setenv("LUA_ROOT", root)

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end
