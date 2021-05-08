#!/bin/bash

set -o errexit
set -o nounset

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

if [ -f "$HOME/.gitconfig" ]; then
  git config --global --get-all --type=path include.path | grep $ROOT_DIR/gitconfig &> /dev/null
  if [ $? == 0 ]; then
    echo "Already included $ROOT_DIR/gitconfig in $HOME/.gitconfig"
  else
    echo "Including $ROOT_DIR/gitconfig in $HOME/.gitconfig"
    git config --global --type=path --add include.path $ROOT_DIR/gitconfig
  fi
else
  echo "Creating $HOME/.gitconfig and including $ROOT_DIR/gitconfig in it"
  touch $HOME/.gitconfig
  git config --global --type=path --add include.path $ROOT_DIR/gitconfig
fi

DELTA_VERSION=0.7.1
wget -q https://github.com/dandavison/delta/releases/download/$DELTA_VERSION/git-delta-musl_$DELTA_VERSION\_amd64.deb -O /tmp/git-delta.deb

if [[ $EUID -ne 0 ]]; then
  sudo dpkg -i /tmp/git-delta.deb
else
  dpkg -i /tmp/git-delta.deb
fi

import-key() {
  curl https://github.com/$1.gpg | gpg --import
}

trust-key() {
  gpg --fingerprint --with-colons --list-keys $1 \
    | sed -E -n -e "s/^fpr:::::::::([0-9A-F]+):$/\1:$2:/p" \
    | gpg --import-ownertrust
}

import-key web-flow
import-key lyang

trust-key noreply@github.com 6
trust-key github@linyang.me 6

chown -R $(whoami) ~/.gnupg/ && chmod 600 ~/.gnupg/* && chmod 700 ~/.gnupg
