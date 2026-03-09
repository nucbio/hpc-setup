-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - Java Development Kit
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Programming Language/Runtime")
whatis("URL: https://openjdk.org/")

local root = "${TOOL_PATH}"

-- Standard Java Environment Variable
setenv("JAVA_HOME", root)

-- Add binaries (java, javac, jar, etc.)
prepend_path("PATH", pathJoin(root, "bin"))

-- Libraries (Required for JNI and linking)
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "$LIB"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "$LIB"))

-- Include headers (Required for JNI/C++ integration)
prepend_path("CPATH", pathJoin(root, "include"))
-- Many tools look for the linux-specific headers as well
prepend_path("CPATH", pathJoin(root, "include/linux"))

-- Man pages
prepend_path("MANPATH", pathJoin(root, "man"))

conflict("${TOOL}")
conflict("jdk")

if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION")
end
