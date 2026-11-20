#!/bin/bash

# jq is installed first: pkg_version/pkg_url and module_templater need it.
# Its own version is read from pkgs.json with sed, since jq is not there yet.

echo "Install jq"

PKG_NAME="jq"
_jq_field() {
  sed -n '/^  "jq": {/,/^  }/s/^ *"'"$1"'": *"\([^"]*\)".*/\1/p' "$REPO_DIR/pkgs.json"
}
JQ_VERSION=$(_jq_field pkg_version)
JQ_URL=$(_jq_field pkg_url)
unset -f _jq_field
if [[ -z "$JQ_VERSION" || -z "$JQ_URL" ]]; then
  echo "ERROR: could not read the jq version/URL from pkgs.json"
  return 1
fi
export JQ_VERSION

JQ_DIR=$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$JQ_VERSION
mkdir -p "$JQ_DIR"
wget -nv "$JQ_URL" -O "$JQ_DIR/jq"
chmod +x "$JQ_DIR/jq"

# Usable right away, before Lmod exists
export PATH="$JQ_DIR:$PATH"

# Modules lua file
module_templater "$PKG_NAME"
