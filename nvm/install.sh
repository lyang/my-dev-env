#!/bin/zsh
set -o errexit

if [ "$(command -v nvm)" = "" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | zsh
fi
