#!/bin/bash

trust-key() {
  gpg --fingerprint --with-colons --list-keys $1 \
    | sed -E -n -e "s/^fpr:::::::::([0-9A-F]+):$/\1:$2:/p" \
    | gpg --import-ownertrust
}

curl --silent https://github.com/lyang.gpg | gpg --import

SIGNING_KEY_ID=$(gpg --keyid-format LONG -K github@linyang.me | grep sec | sed 's/^.*\/\([^ ]*\) .*/\1/')
if [ -n "$SIGNING_KEY_ID" ]; then
  git config --global user.signingkey $SIGNING_KEY_ID
  git config --global commit.gpgsign true
  echo "Code Signing Key Found: $SIGNING_KEY_ID"
else
  git config --global --unset user.signingkey
  git config --global --unset commit.gpgsign
  echo "Code Signing Key Not Found"
fi

trust-key noreply@github.com 6
trust-key github@linyang.me 6

git clone https://github.com/lyang/Dockerfiles.git
git clone https://github.com/lyang/my-dot-files.git

./my-dot-files/setup.sh

tmux new-session -d -s dev
tmux attach -t dev
