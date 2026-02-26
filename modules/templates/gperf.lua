-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - GNU perfect hash function generator.

This is a build-time dependency required for compiling Fontconfig, 
Glib, and other system-level libraries. It generates a perfect hash 
function from a set of keywords.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Development/Tools")
whatis("Description: GNU gperf is a perfect hash function generator. For a given list of strings, it produces a hash function and hash table, in C or C++ code.")
whatis("URL: https://www.gnu.org/software/gperf/")

local root = "${TOOL_PATH}"

-- Primary Binary (gperf)
prepend_path("PATH", pathJoin(root, "bin"))

-- Standard library and include paths (though rarely used by other tools)
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "$LIB"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "$LIB"))
prepend_path("CPATH",           pathJoin(root, "include"))

-- Man pages and Info pages
prepend_path("MANPATH",  pathJoin(root, "share/man"))
prepend_path("INFOPATH", pathJoin(root, "share/info"))

-- Developer variable
setenv("GPERF", pathJoin(root, "bin/gperf"))

conflict("${TOOL}")

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end
