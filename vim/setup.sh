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
  echo "source $ROOT_DIR/init.vim" >> $HOME/.vimrc
fi

mkdir -p $HOME/.vim/tmp $HOME/.vim/undo

if [ -f "$HOME/.vim/coc-settings.json" ]; then
  echo "Backing up previous coc-settings to $HOME/.vim/coc-settings.json-$(date +%Y%m%d%H%M%S)"
  mv $HOME/.vim/coc-settings.json $HOME/.vim/coc-settings.json-$(date +%Y%m%d%H%M%S)
fi

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -es -u $HOME/.vimrc -i NONE -c "PlugInstall" -c "qa"

echo "Symlinking $ROOT_DIR/coc-settings.json to $HOME/.vim/coc-settings.json"
ln -fs $ROOT_DIR/coc-settings.json $HOME/.vim/coc-settings.json

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
  echo "source $ROOT_DIR/init.vim" >> $HOME/.vimrc
fi

if [ -f "$HOME/.config/nvim/coc-settings.json" ]; then
  echo "Backing up previous coc-settings to $HOME/.config/nvim/coc-settings.json-$(date +%Y%m%d%H%M%S)"
  mv $HOME/.config/nvim/coc-settings.json $HOME/.config/nvim/coc-settings.json-$(date +%Y%m%d%H%M%S)
fi
echo "Symlinking $ROOT_DIR/coc-settings.json to $HOME/.config/nvim/coc-settings.json"
ln -fs $ROOT_DIR/coc-settings.json $HOME/.config/nvim/coc-settings.json

curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -es -u init.vim -i NONE -c "PlugInstall" -c "qa"
