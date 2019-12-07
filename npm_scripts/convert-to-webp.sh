#!/bin/bash

set -euo pipefail

__main() {
  local root="$1"

  if [ ! -d "$root" ]
  then
    printf -- 'Base directory path is not found.\n' >&2
    exit 1
  fi

  if ! type cwebp >/dev/null 2>&1
  then
    printf -- 'cwebp is not found.\n' >&2
    exit 1
  fi

  printf -- 'Convert to webp...\n'

  local script='cwebp -q 80 "%" -o "$(printf -- "%" | sed -e "s|\.[^.]*$||").webp"'

  find "$root" \
    -type d -name node_modules -prune -or \
    -type d -name public -prune -or \
    -type f -iregex '.*\.png$' -print0 |
    xargs -0 -I % bash -c "$script"

  printf -- 'Convert finished.\n'
}

__main "$@"

unset -f __main
