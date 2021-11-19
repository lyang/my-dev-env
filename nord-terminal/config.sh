#!/bin/zsh

if [ $(uname) = "Darwin" ]; then
  open -a iterm /tmp/Nord.itermcolors
else
  cd $HOME/.nord-gnome-terminal/src && git pull && ./nord.sh
fi
