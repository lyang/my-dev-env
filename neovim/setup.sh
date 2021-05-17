#!/bin/bash

set -o errexit
set -o nounset

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

if [ -f "$HOME/.config/nvim/init.vim" ]; then
  grep "source $ROOT_DIR/init.vim" $HOME/.config/nvim/init.vim &> /dev/null
  if [ $? == 0 ]; then
    echo "Already included $ROOT_DIR/init.vim in $HOME/.config/nvim/init.vim"
  else
    echo "Including $ROOT_DIR/init.vim in $HOME/.config/nvim/init.vim"
    echo "source $ROOT_DIR/init.vim" >> $HOME/.config/nvim/init.vim
  fi
else
  echo "Creating $HOME/.config/nvim/init.vim and including $ROOT_DIR/init.vim in it"
  mkdir -p $HOME/.config/nvim
  touch $HOME/.config/nvim/init.vim
  echo "source $ROOT_DIR/init.vim" >> $HOME/.config/nvim/init.vim
fi

nvim --headless +PlugInstall +qall
