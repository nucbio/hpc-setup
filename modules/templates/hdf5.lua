-- ${TOOL} version ${TOOL_VERSION}
whatis("${TOOL} version ${TOOL_VERSION}")

local root = "${TOOL_PATH}"

-- Add binaries to PATH (h5dump, h5cc, etc.)
prepend_path("PATH", pathJoin(root, "bin"))

-- Standard library paths
-- Note: HDF5 often installs to 'lib', check if your build uses 'lib64'
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "lib"))
prepend_path("CPATH",           pathJoin(root, "include"))

-- Variables for CMake and high-level wrappers
setenv("HDF5_ROOT", root)
setenv("HDF5_DIR",  root)
prepend_path("CMAKE_PREFIX_PATH", root)

-- pkg-config support
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib/pkgconfig"))
