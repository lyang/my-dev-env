#!/bin/zsh

if [ $(uname) = "Darwin" ]; then
  curl -sfLo /tmp/Nord.itermcolors https://raw.githubusercontent.com/arcticicestudio/nord-iterm2/develop/src/xml/Nord.itermcolors
elif [ -d "$HOME/.nord-gnome-terminal" ]; then
  git -C $HOME/.nord-gnome-terminal pull
else
  git clone https://github.com/arcticicestudio/nord-gnome-terminal.git $HOME/.nord-gnome-terminal
fi
