#!/bin/bash

trust-key() {
  gpg --fingerprint --with-colons --list-keys $1 \
    | sed -E -n -e "s/^fpr:::::::::([0-9A-F]+):$/\1:$2:/p" \
    | gpg --import-ownertrust
}

curl --silent https://github.com/lyang.gpg | gpg --import

trust-key noreply@github.com 6
trust-key github@linyang.me 6

tmux new-session -d -s dev
tmux attach -t dev
