#!/bin/bash

set -euo pipefail

__main() {
  local root="$1"

  if [ ! -d "$root" ]
  then
    printf -- 'Base directory path is not found.\n' >&2
    exit 1
  fi

  if [ ! -f "${root}/package.json" ]
  then
    printf -- 'package.json not found in target directory.\n' >&2
    exit 1
  fi

  local bin=

  bin="${root}/node_modules/.bin"

  if [ -f "${bin}/cwebp" ]
  then
    printf -- 'cwebp is installed.\n'
    exit 0
  fi

  printf -- 'Downloading cwebp...\n'

  local os=

  os="$(uname)"

  local url='https://storage.googleapis.com/downloads.webmproject.org/releases/webp'

  case "$os" in
    Darwin)
      url="${url}/libwebp-1.0.3-mac-10.14.tar.gz"
      ;;
    Linux)
      url="${url}/libwebp-1.0.3-linux-x86-64.tar.gz"
      ;;
    *)
      printf -- 'Unsupported platform.\n' >&2
      exit 1
      ;;
  esac

  local tempdir=

  tempdir="$(mktemp -d '/tmp/XXXXXXXXXX')"

  local file="${tempdir}/libwebp.tar.gz"

  if type curl >/dev/null 2>&1
  then
    curl -fsSL "$url" -o "$file"
  elif type wget >/dev/null 2>&1
  then
    wget "$url" -O "$file"
  else
    printf -- 'This command needs curl or wget.\n' >&2
    exit 1
  fi

  mkdir -p "$bin"

  tar xvfz "$file" -C "$bin" --strip-components 2 '*/bin/cwebp' >/dev/null 2>&1

  rm -rf "${tempdir}"

  printf -- '%s\n' "Extract to ${bin}/cwebp."
  printf -- 'Download finished.\n'
}

__main "$@"

unset -f __main
