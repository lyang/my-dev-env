#!/bin/zsh

pyenv install --skip-existing 3.9.7 && pyenv global 3.9.7
pip install --upgrade pip
pip install pynvim pyright
