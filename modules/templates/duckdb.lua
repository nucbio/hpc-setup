-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} – Embedded analytical database

This module makes the duckdb executable available.
Installed at:
  ${TOOL_PATH}
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Database")
whatis("Description: DuckDB embedded analytical database")
whatis("URL: https://duckdb.org/")

local root = "${TOOL_PATH}"

prepend_path("PATH", root)
setenv("DUCKDB_HOME", root)
