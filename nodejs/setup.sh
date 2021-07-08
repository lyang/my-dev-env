#!/bin/zsh

set -o errexit
set -o nounset

nvm install --lts
npm install -g bash-language-server vim-language-server neovim 
