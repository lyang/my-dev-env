#!/bin/bash

set -o errexit
set -o nounset

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

pyenv install 3.9.5 && pyenv global 3.9.5
pip install --user cookiecutter
ln -fs $ROOT_DIR/cookiecutterrc $HOME/.cookiecutterrc
