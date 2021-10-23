#!/bin/zsh
set -o errexit

if [ "$(command -v sdk)" = "" ]; then
  curl -s "https://get.sdkman.io" | zsh
else
  sdk update
fi
