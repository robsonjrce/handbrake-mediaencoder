#!/bin/bash

set -e
set -o pipefail

# ~/.profile: local user .profile file for the Bourne shell (sh(1))
# and Bourne compatible shells (bash(1), ksh(1), ash(1), ...).

if [ -d /etc/profile.d ]; then
  for i in /etc/profile.d/*.sh; do
    if [ -r $i ]; then
      echo ":: source $i"
      . $i
    fi
  done
  unset i
fi

if [[ $# -ge 1 && -x $(which $1 2>&-) ]]; then
  exec "$@"
else
  bash
fi

exit 0