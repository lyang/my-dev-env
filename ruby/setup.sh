#!/bin/bash

set -o errexit
set -o nounset

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

rbenv install 2.7.3
rbenv global 2.7.3
gem install bundler neovim
