#!/bin/bash

set -o nounset

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

if [ -f "$HOME/.gitconfig" ]; then
  git config --global --get-all --type=path include.path | grep $ROOT_DIR/gitconfig &> /dev/null
  if [ $? == 0 ]; then
    echo "Already included $ROOT_DIR/gitconfig in $HOME/.gitconfig"
  else
    echo "Including $ROOT_DIR/gitconfig in $HOME/.gitconfig"
    git config --global --type=path --add include.path $ROOT_DIR/gitconfig
  fi
else
  echo "Creating $HOME/.gitconfig and including $ROOT_DIR/gitconfig in it"
  touch $HOME/.gitconfig
  git config --global --type=path --add include.path $ROOT_DIR/gitconfig
fi
