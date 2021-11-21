#!/bin/zsh
set -o errexit

if [ -d "$HOME/.tmux/plugins/tpm" ]; then
  git -C $HOME/.tmux/plugins/tpm pull
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
