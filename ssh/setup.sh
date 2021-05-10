#!/bin/bash

set -o errexit
set -o nounset

mkdir -m 700 $HOME/.ssh
ssh-keyscan github.com > $HOME/.ssh/known_hosts
