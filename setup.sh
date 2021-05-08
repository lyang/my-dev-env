#!/bin/bash

set -o errexit
set -o nounset

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

find $ROOT_DIR/*/ -type f -iname setup.sh -exec '{}' \;

find $HOME/*/.git -type f -iname config -exec sed -i 's/https:\/\/github.com\/lyang\//git@github.com:lyang\//' {} \;
