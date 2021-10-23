#!/bin/zsh
set -o errexit

if [ "$(uname)" = "Darwin" ]; then
  brew install tmux
else
  if [ -d $HOME/.tmux ]; then
    git -C $HOME/.tmux fetch
  else
    git clone https://github.com/tmux/tmux.git $HOME/.tmux
  fi

  if [ "$(tmux -V)" != "tmux 3.2a" ]; then
    cd $HOME/.tmux  && git checkout 3.2a && sh autogen.sh && ./configure && make && sudo make install
  fi
fi

if [ -d "$HOME/.tmux/plugins/tpm" ]; then
  git -C $HOME/.tmux/plugins/tpm pull
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
