-- ${TOOL} version ${TOOL_VERSION}

whatis("$TOOL version $TOOL_VERSION")

-- Using the resolved TOOL_PATH from the Bash function
prepend_path("PATH", "$TOOL_PATH")

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end
