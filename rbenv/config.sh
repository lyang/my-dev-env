#!/bin/zsh

eval "$(rbenv init - zsh)"
rbenv install --skip-existing 3.1.2 && rbenv global 3.1.2
rbenv rehash && gem install bundler neovim solargraph
