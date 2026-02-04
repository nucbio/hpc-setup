-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - Cryptography and SSL/TLS Toolkit

This module provides the headers and libraries for ${TOOL}.
Essential for compiling Python with SSL support and for R packages 
like 'openssl' or 'git2r'.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Library/Security")
whatis("Description: Robust, commercial-grade, and full-featured toolkit for TLS and SSL.")
whatis("URL: https://www.openssl.org/")

local root = "${TOOL_PATH}"

-- Binaries (openssl executable)
prepend_path("PATH", pathJoin(root, "bin"))

-- Libraries (Note: OpenSSL 3.x often uses 'lib64', 1.x often uses 'lib')
-- We include both common patterns for safety
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib64"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "lib64"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "lib"))

-- Includes
prepend_path("CPATH",           pathJoin(root, "include"))

-- pkg-config
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib64/pkgconfig"))
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib/pkgconfig"))

-- Essential variables for Python and CMake builds
setenv("OPENSSL_ROOT_DIR", root)
setenv("OPENSSL_INCLUDE_DIR", pathJoin(root, "include"))
setenv("OPENSSL_LIBRARIES", pathJoin(root, "lib64"))

-- For older autotools based configures
setenv("SSL_CERT_FILE", pathJoin(root, "ssl/cert.pem"))
setenv("SSL_CERT_DIR",  pathJoin(root, "ssl/certs"))
