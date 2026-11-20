#!/bin/bash

LUAROCKS_VERSION="3.13.0" # Latest stable
cd "$SOURCE_DIR"

# Download source
wget https://luarocks.github.io/luarocks/releases/luarocks-${LUAROCKS_VERSION}.tar.gz
tar -xzf luarocks-${LUAROCKS_VERSION}.tar.gz
cd luarocks-${LUAROCKS_VERSION}

# Configure to point specifically to your local Lua
./configure \
    --prefix="$LUA_DIR" \
    --with-lua="$LUA_DIR" \
    --with-lua-include="$LUA_DIR/include" \
    --with-lua-lib="$LUA_DIR/lib"

make
make install

# Clean up
cd ..
rm -rf luarocks-${LUAROCKS_VERSION}

# Install Lua Packages
# Pinned: Lmod 9.5 uses the new luaposix interface (posix.sys.stat) and supports
# luaposix 38. Older Lmod (<= 9.4) needs posix.stat, which luaposix >= 37 removed,
# and luarocks has no luaposix <= 36 for Lua 5.5. Keep Lmod, Lua and luaposix in step
# (a mismatch makes Lmod's make install fail at man_pages; the error ends up in
# share/man/man1/module.pod).
LUASOCKET_VERSION="3.1.0-1"
LUAPOSIX_VERSION="38-1"
LUAFILESYSTEM_VERSION="1.9.0-1"

LUAROCKS=$LUA_DIR/bin/luarocks

$LUAROCKS install luasocket     "$LUASOCKET_VERSION"
$LUAROCKS install luaposix      "$LUAPOSIX_VERSION"
$LUAROCKS install luafilesystem "$LUAFILESYSTEM_VERSION"

# Check the Lua modules Lmod needs (with the rock paths, as Lmod's configure uses them)
if ! ( eval "$($LUAROCKS path)"; "$LUA_DIR/bin/lua" -e 'assert(require("posix.sys.stat").stat("/"), "posix.sys.stat failed"); require("posix.unistd"); require("lfs")' ); then
    echo "ERROR: Lua modules for Lmod (luaposix with posix.sys.stat, luafilesystem) are not usable."
    return 1
fi
