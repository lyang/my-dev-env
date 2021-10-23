#!/bin/bash
set -o errexit

source $HOME/.nvm/nvm.sh
nvm install --lts --latest-npm
npm install -g bash-language-server vim-language-server neovim 
