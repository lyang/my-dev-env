#!/bin/bash

set -o errexit
set -o nounset

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

if [ -f "$HOME/.vimrc" ]; then
  grep "source $ROOT_DIR/vimrc" $HOME/.vimrc &> /dev/null
  if [ $? == 0 ]; then
    echo "Already included $ROOT_DIR/vimrc in $HOME/.vimrc"
  else
    echo "Including $ROOT_DIR/vimrc in $HOME/.vimrc"
    echo "source $ROOT_DIR/vimrc" >> $HOME/.vimrc
  fi
else
  echo "Creating $HOME/.vimrc and including $ROOT_DIR/vimrc in it"
  touch $HOME/.vimrc
  echo "source $ROOT_DIR/vimrc" >> $HOME/.vimrc
fi

mkdir -p $HOME/.vim/tmp $HOME/.vim/undo
vim -es -u $HOME/.vimrc -i NONE -c "PlugInstall" -c "qa"
