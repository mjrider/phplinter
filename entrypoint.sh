#!/usr/bin/env sh

set -o errexit -o nounset -o pipefail 

entrypoint() {
  # Allow this, our target is dash/busybox
  # shellcheck disable=SC2039
  local A

  # GITHUB escapaes to much, so 'unescape' it ;-(
  if [  ${GITHUB_ACTIONS:-} == "true" ]
    exec ${@}
  fi
  # CI is set, just execute the arguments
  if [ -n "${CI:-}" ] ; then
    exec "${@}"
  fi

  # workplace detecting
  readonly A="${1:-}"
  if [ -n "${A}" ] && [ -n "$(command -v "${A}" 2>/dev/null)" ] ; then
    exec "${@}"
  else
    exec "${DEFAULTCMD}" "${@}"
  fi
}

entrypoint "$@"
