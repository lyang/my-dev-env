#!/bin/zsh
set -o errexit

if [ "$(command -v nvim)" = "" ]; then
  if [ "$(uname)" = "Darwin" ]; then
    brew install neovim
  else
    NVIM_DIR="/usr/local/nvim"
    sudo sh -c " 
    curl -sfLo $NVIM_DIR/nvim.appimage --create-dir https://github.com/neovim/neovim/releases/latest/download/nvim.appimage &&
    chmod u+x $NVIM_DIR/nvim.appimage &&
    cd $NVIM_DIR && $NVIM_DIR/nvim.appimage --appimage-extract &&
    chmod -R a+rX $NVIM_DIR &&
    ln -fs $NVIM_DIR/squashfs-root/AppRun /usr/local/bin/nvim
    "
  fi
  mkdir -p $HOME/.config/nvim/tmp $HOME/.config/nvim/undo
  curl -sfLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
