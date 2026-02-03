-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - Shared library for command-line editing.
Required for interactive R console support.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Description: GNU Readline library for command-line editing and history.")

local root = "${TOOL_PATH}"

prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "lib"))
prepend_path("CPATH",           pathJoin(root, "include"))

-- Crucial for some compilers to pick up the paths automatically
prepend_path("C_INCLUDE_PATH",      pathJoin(root, "include"))
prepend_path("CPLUS_INCLUDE_PATH",  pathJoin(root, "include"))

-- Specific variable for R's ./configure
setenv("READLINE_ROOT", root)
setenv("READLINE_LIBS", "-L" .. pathJoin(root, "lib") .. " -lreadline")

prepend_path("LDFLAGS", "-L" .. pathJoin(root, "lib"), " ")
prepend_path("CPPFLAGS", "-I" .. pathJoin(root, "include"), " ")

