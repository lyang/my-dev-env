#!/bin/zsh
set -o errexit

if [ -d $HOME/.tfenv ]; then
  git -C $HOME/.tfenv pull
else
  git clone https://github.com/tfutils/tfenv.git $HOME/.tfenv
  echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> $HOME/.zprofile
fi
