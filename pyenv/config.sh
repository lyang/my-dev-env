#!/bin/zsh

VERSIONS=(3.10.1 3.9.9 3.8.12 3.7.12)

for version in $VERSIONS; do
  pyenv install --skip-existing $version && pyenv local $version
  pip install --upgrade pip
  pip install podman-compose pre-commit pynvim pyright tox tox-pyenv
done

pyenv global ${VERSIONS[1]}

if [ "$(command -v poetry)" = "" ]; then
  curl -sSL https://install.python-poetry.org | python -
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> $HOME/.zprofile
fi
