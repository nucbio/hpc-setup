#!/bin/bash

# Stamps record installed packages, so a rerun of boot.sh skips them.
#
# - One stamp per package: $INSTALL_DIR/.stamps/NAME-VERSION.done
#   Key = name + version: bumping a version in pkgs.json builds the new version.
# - Written in ONE place: at the end of module_templater, the last step of every
#   install (only for real packages, not meta-modules).
# - Checked at the start of every install script with skip_if_installed, placed
#   after the exports / module loads that later steps need.
#
# Rebuild a package: FORCE_REBUILD="zlib openssl" (or "all") ./boot.sh
#                    or delete .stamps/NAME-VERSION.done
# FORCE_REBUILD is not remembered: drop it for the next rerun, or the
# packages are built again.

STAMP_DIR="$INSTALL_DIR/.stamps"

# True if NAME is listed in FORCE_REBUILD (or FORCE_REBUILD=all)
is_forced() {
  [[ " $FORCE_REBUILD " == *" all "* || " $FORCE_REBUILD " == *" $1 "* ]]
}

# Install script that called us: first caller outside functions/
_stamp_caller() {
  local f
  for f in "${BASH_SOURCE[@]}"; do
    [[ "$f" == "$REPO_DIR/functions/"* ]] && continue
    printf '%s\n' "$f"
    return 0
  done
}

_stamp_hash() {
  [[ -f "$1" ]] && sha1sum "$1" | cut -d' ' -f1
}

# is_installed NAME VER
# True if the stamp, the module file and the module's root all exist.
# The root check catches packages that live inside another package
# (cargo tools in rust's prefix) and prefixes deleted by hand.
is_installed() {
  local name="$1" ver="$2" lua root
  is_forced "$name" && return 1
  lua="$INSTALL_DIR/modulefiles/$name/$ver.lua"
  [[ -f "$STAMP_DIR/$name-$ver.done" && -f "$lua" ]] || return 1
  root=$(sed -n 's/^local root = "\(.*\)"$/\1/p' "$lua" | head -n 1)
  [[ -n "$root" && -d "$root" ]]
}

# Remove leftovers of a failed attempt: install prefix and build dirs
clean_partial() {
  local name="${1:?}" ver="${2:?}"
  local prefix="${INSTALL_DIR:?}/$name/$name-$ver"
  if [[ -e "$prefix" ]]; then
    echo "Removing leftovers of a previous attempt: $prefix"
    rm -rf "$prefix"
  fi
  if [[ -n "$BUILD_BASE" ]]; then
    rm -rf "$BUILD_BASE/$name/$name-$ver"/build-*
  fi
}

# Warn (only) if the install script changed since the package was built
_stamp_stale_warn() {
  local name="$1" ver="$2" script old new
  script=$(_stamp_caller)
  new=$(_stamp_hash "$script")
  old=$(sed -n 's/^sha1: //p' "$STAMP_DIR/$name-$ver.done")
  if [[ -n "$old" && -n "$new" && "$old" != "$new" ]]; then
    echo "[STALE] ${script#"$REPO_DIR"/} changed since $name $ver was built." \
         "Rerun with FORCE_REBUILD=$name to rebuild it."
  fi
}

# skip_if_installed NAME VER [--noclean] [--after STAMP]
# Returns 0 (and prints [SKIP]) if NAME VER is installed.
# Otherwise removes leftovers of a failed attempt and returns 1.
#   --noclean     do not remove the prefix (cargo tools: shared root)
#   --after STAMP also rebuild if stamp STAMP (e.g. "rust-1.100.0") is newer
# Use as: if skip_if_installed "$PKG_NAME" "$PKG_VERSION"; then return 0; fi
skip_if_installed() {
  local name="$1" ver="$2" clean=1 after=""
  shift 2
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --noclean) clean=0 ;;
      --after)   after="$2"; shift ;;
      *) echo "skip_if_installed: unknown option $1" >&2; return 2 ;;
    esac
    shift
  done

  if is_installed "$name" "$ver"; then
    if [[ -n "$after" && "$STAMP_DIR/$after.done" -nt "$STAMP_DIR/$name-$ver.done" ]]; then
      echo "$name $ver: $after was rebuilt after it, rebuilding."
    else
      echo "[SKIP] $name $ver already installed"
      _stamp_stale_warn "$name" "$ver"
      return 0
    fi
  fi

  [[ $clean -eq 1 ]] && clean_partial "$name" "$ver"
  return 1
}

# mark_installed NAME VER [DEP...]
# Called by module_templater after the module file is written.
# Stores the date, the install script and its sha1 (for the stale warning)
# and the dependency versions (informational).
mark_installed() {
  local name="$1" ver="$2" script dep
  shift 2
  script=$(_stamp_caller)
  mkdir -p "$STAMP_DIR"
  {
    echo "date: $(date -Is)"
    echo "script: ${script#"$REPO_DIR"/}"
    echo "sha1: $(_stamp_hash "$script")"
    for dep in "$@"; do
      echo "dep: $dep $(pkg_version "$dep" 2>/dev/null)"
    done
  } > "$STAMP_DIR/$name-$ver.done.tmp"
  mv "$STAMP_DIR/$name-$ver.done.tmp" "$STAMP_DIR/$name-$ver.done"
}
