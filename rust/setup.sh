#!/bin/bash

set -o errexit
set -o nounset

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

cargo install bat git-delta
