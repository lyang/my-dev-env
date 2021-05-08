#!/bin/bash

set -o errexit
set -o nounset

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

ln -fs $ROOT_DIR/cookiecutterrc $HOME/.cookiecutterrc
