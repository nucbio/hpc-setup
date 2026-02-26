-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - The GLib package contains low-level core libraries.
GLib provides the core application building blocks for libraries and applications
written in C. It provides data structure handling for C, portability wrappers,
and interfaces for such runtime functionality as an event loop, threads, dynamic
loading, and an object system. GLib is a foundational library for GTK and GNOME.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Library/Core")
whatis("Description: GLib is a general-purpose utility library providing core building blocks.")
whatis("URL: https://www.gtk.org/")

local root = "${TOOL_PATH}"

local bin = pathJoin(root, "bin")
local lib = pathJoin(root, "$LIB")
local include = pathJoin(root, "include")
local pkg_conf = pathJoin(root, "$PKG_CONF")
local man = pathJoin(root, "share/man")

-- Binaries (glib includes several utilities)
prepend_path("PATH", pathJoin(root, "bin"))

-- Libraries
prepend_path("LD_LIBRARY_PATH", lib)
prepend_path("LIBRARY_PATH",    lib)

-- Includes
prepend_path("CPATH",           include)
prepend_path("C_INCLUDE_PATH",  include)
prepend_path("CPLUS_INCLUDE_PATH", include)

-- Compiler/Linker flags
prepend_path("LDFLAGS", "-L" .. lib, " ")
prepend_path("CPPFLAGS", "-I" .. include, " ")

-- PKG_CONFIG_PATH for .pc files
prepend_path("PKG_CONFIG_PATH", pkg_conf)

-- GLib-specific paths
prepend_path("XDG_DATA_DIRS", pathJoin(root, "share"))
prepend_path("GIO_MODULE_DIR", pathJoin(root, "$LIB/gio/modules"))

-- GSettings schema directory
prepend_path("GSETTINGS_SCHEMA_DIR", pathJoin(root, "share/glib-2.0/schemas"))

-- Environment variables for build systems
setenv("GLIB_ROOT", root)
setenv("GLIB_HOME", root)
setenv("GLIB_INCLUDE_DIR", include)
setenv("GLIB_LIBRARY_DIR", lib)

-- Man pages
prepend_path("MANPATH", man)

-- Aclocal path for m4 macros
prepend_path("ACLOCAL_PATH", pathJoin(root, "share/aclocal"))

-- Bash completion
prepend_path("BASH_COMPLETION_DIR", pathJoin(root, "share/bash-completion/completions"))

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end
