#!/bin/zsh
set -o errexit

if [ -d $HOME/.nerd-fonts ]; then
  git -C $HOME/.nerd-fonts pull
else
  git clone --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts $HOME/.nerd-fonts
  git -C $HOME/.nerd-fonts sparse-checkout add patched-fonts/Meslo
fi

$HOME/.nerd-fonts/install.sh --clean --quiet
