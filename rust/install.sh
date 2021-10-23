#!/bin/zsh
set -o errexit

if [ "$(command -v rustup)" = "" ]; then
  curl --silent --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | zsh -s -- -y
else
  rustup update
fi
