#!/bin/zsh

if [ $(uname) = "Darwin" ]; then
  curl -sfLo /tmp/Nord.itermcolors https://raw.githubusercontent.com/arcticicestudio/nord-iterm2/develop/src/xml/Nord.itermcolors
else
  git clone https://github.com/arcticicestudio/nord-gnome-terminal.git $HOME/.nord-gnome-terminal
fi
