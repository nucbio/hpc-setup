-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} (XZ Utils) ${TOOL_VERSION} - Data compression software with high compression ratio.
Provides the liblzma library.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Description: XZ Utils is free general-purpose data compression software (LZMA).")

local root = "${TOOL_PATH}"

prepend_path("PATH",            pathJoin(root, "bin"))
prepend_path("CPATH",           pathJoin(root, "include"))
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "$PKG_CONF"))
prepend_path("LDFLAGS", "-L" .. pathJoin(root, "$LIB"), " ")
prepend_path("CPPFLAGS", "-I" .. pathJoin(root, "include"), " ")

setenv("LZMA_ROOT", root)
