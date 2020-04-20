#!/usr/bin/env bash
set -e

resolve_link() {
  $(type -p greadlink readlink | head -1) "$1"
}

abs_dirname() {
  local cwd="$(pwd)"
  local path="$1"

  while [ -n "$path" ]; do
    cd "${path%/*}"
    local name="${path##*/}"
    path="$(resolve_link "$name" || true)"
  done

  pwd
  cd "$cwd"
}

PREFIX="/usr/local"
P_ROOT="$(abs_dirname "$0")"
mkdir -p "$PREFIX"/{bin,libexec}
cp -R "$P_ROOT"/bin/* "$PREFIX"/bin
cp -R "$P_ROOT"/libexec/* "$PREFIX"/libexec

echo "Installed to $PREFIX/bin/p"
