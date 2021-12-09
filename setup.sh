#!/bin/zsh
set -o errexit

CURRENT_DIR=${0:A:h}

for install in $(find $CURRENT_DIR/* -type f -iname install.sh); do
  $install
done

for config in $(find $CURRENT_DIR/* -type f -iname config.sh); do
  zsh -lc $config
done

echo 'Setup finished. Please restart your terminal'
