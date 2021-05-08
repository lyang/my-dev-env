#!/bin/bash

set -o errexit
set -o nounset

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

gem install bundler
mkdir -p $HOME/.bundle
ln -fs $ROOT_DIR/config $HOME/.bundle/config
