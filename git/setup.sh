#!/bin/bash

set -o nounset

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

SIGNING_KEY_ID=$(gpg --keyid-format LONG -K github@linyang.me | grep sec | sed 's/^.*\/\([^ ]*\) .*/\1/')
if [ -n "$SIGNING_KEY_ID" ]; then
  git config --global user.signingkey $SIGNING_KEY_ID
  git config --global commit.gpgsign true
  echo "Code Signing Key Found: $SIGNING_KEY_ID"
else
  git config --global --unset user.signingkey
  git config --global --unset commit.gpgsign
  echo "Code Signing Key Not Found"
fi

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
