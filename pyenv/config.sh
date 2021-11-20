#!/bin/zsh

pyenv install --skip-existing 3.9.7 && pyenv global 3.9.7
pip install --upgrade pip
pip install pre-commit pynvim pyright

if [ "$(command -v poetry)" = "" ]; then
  curl -sSL https://install.python-poetry.org | python -
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> $HOME/.zprofile
fi
