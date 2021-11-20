#!/bin/zsh

if [ $(uname) = "Darwin" ]; then
  open -a iterm /tmp/Nord.itermcolors
elif [ -n "$XDG_CURRENT_DESKTOP" ]; then
  cd $HOME/.nord-gnome-terminal/src && git pull && ./nord.sh
fi
