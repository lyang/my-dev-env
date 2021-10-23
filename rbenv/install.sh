#!/bin/zsh
set -o errexit

if [ -d $HOME/.rbenv ]; then
  git -C $HOME/.rbenv pull
  git -C $HOME/.rbenv/plugins/ruby-build pull
else
  git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
  git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
  cd $HOME/.rbenv && src/configure && make -C src
  echo 'export RBENV_ROOT=$HOME/.rbenv' >> $HOME/.zshenv
  echo 'export PATH=$RBENV_ROOT/bin:$PATH' >> $HOME/.zshenv
  echo 'eval "$(rbenv init - zsh)"' >> $HOME/.zshrc
fi
