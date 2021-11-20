#!/bin/zsh
set -o errexit

if [ -d $HOME/.pyenv ]; then
  git -C $HOME/.pyenv pull
  git -C $HOME/.pyenv/plugins/pyenv-virtualenv pull
else
  git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
  git clone https://github.com/pyenv/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv
  cd $HOME/.pyenv && src/configure && make -C src
  echo 'export PYENV_ROOT=$HOME/.pyenv' >> $HOME/.zprofile
  echo 'export PATH=$PYENV_ROOT/bin:$PATH' >> $HOME/.zprofile
  echo 'export PYENV_VIRTUALENV_DISABLE_PROMPT=1' >> $HOME/.zprofile
  echo 'eval "$(pyenv init --path)"' >> $HOME/.zprofile
  echo 'eval "$(pyenv init -)"' >> $HOME/.zprofile
  echo 'eval "$(pyenv virtualenv-init -)"' >> $HOME/.zprofile
fi
