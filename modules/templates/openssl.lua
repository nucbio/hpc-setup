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

-- Includes
prepend_path("LD_LIBRARY_PATH",  pathJoin(root, "$LIB"))
prepend_path("LIBRARY_PATH",     pathJoin(root, "$LIB"))
prepend_path("CPATH",            pathJoin(root, "include"))
prepend_path("LDFLAGS", "-L" ..  pathJoin(root, "$LIB"), " ")
prepend_path("CPPFLAGS", "-I" .. pathJoin(root, "include"), " ")

-- pkg-config
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "$PKG_CONF"))

-- Essential variables for Python and CMake builds
setenv("OPENSSL_ROOT_DIR", root)
setenv("OPENSSL_INCLUDE_DIR", pathJoin(root, "include"))
setenv("OPENSSL_LIBRARIES", pathJoin(root, "$LIB"))

-- System Sertificates (critical for proxy)
setenv("SSL_CERT_FILE", "/etc/ssl/certs/ca-certificates.crt")
setenv("SSL_CERT_DIR", "/etc/ssl/certs")

