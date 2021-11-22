#!/bin/zsh
set -o errexit

if [ "$(uname)" = "Darwin" ]; then
  podman machine init && podman machine start
fi
