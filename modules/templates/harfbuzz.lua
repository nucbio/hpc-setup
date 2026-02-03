-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - OpenType text shaping engine
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: library")
whatis("Description: OpenType text shaping engine")
whatis("URL: https://harfbuzz.github.io/")

local base = "${TOOL_PATH}"

-- Prepend paths
prepend_path("PATH",            pathJoin(base, "bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(base, "lib64"))
prepend_path("LIBRARY_PATH",    pathJoin(base, "lib64"))
prepend_path("CPATH",           pathJoin(base, "include"))
prepend_path("PKG_CONFIG_PATH", pathJoin(base, "lib64/pkgconfig"))

-- Set environment variables for R package compilation
setenv("HARFBUZZ_ROOT",    base)
setenv("HARFBUZZ_HOME",    base)
setenv("HARFBUZZ_INCLUDE", pathJoin(base, "include"))
setenv("HARFBUZZ_LIB",     pathJoin(base, "lib64"))

-- Additional variables that R's configure scripts might check
pushenv("CFLAGS",   "-I" .. pathJoin(base, "include"))
pushenv("CXXFLAGS", "-I" .. pathJoin(base, "include"))
pushenv("LDFLAGS",  "-L" .. pathJoin(base, "lib64"))

-- For R packages that might look for harfbuzz-config
pushenv("CPPFLAGS", "-I" .. pathJoin(base, "include/harfbuzz"))

-- Conflict with other versions of the same tool
conflict("${TOOL}")
