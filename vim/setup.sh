#!/bin/bash

set -o nounset

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

if [ -f "$HOME/.vimrc" ]; then
  grep "source $ROOT_DIR/init.vim" $HOME/.vimrc &> /dev/null
  if [ $? == 0 ]; then
    echo "Already included $ROOT_DIR/init.vim in $HOME/.vimrc"
  else
    echo "Including $ROOT_DIR/init.vim in $HOME/.vimrc"
    echo "source $ROOT_DIR/init.vim" >> $HOME/.vimrc
  fi
else
  echo "Creating $HOME/.vimrc and including $ROOT_DIR/init.vim in it"
  touch $HOME/.vimrc
  echo "source $ROOT_DIR/init.vim" >> $HOME/.vimrc
fi

mkdir -p $HOME/.vim/tmp $HOME/.vim/undo
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -es -u $HOME/.vimrc -i NONE -c "PlugInstall" -c "qa"
