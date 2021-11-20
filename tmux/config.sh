#!/bin/zsh
set -o errexit

CURRENT_DIR=${0:A:h}

if [ -f "$HOME/.tmux.conf" ]; then
  grep "source-file $CURRENT_DIR/tmux.conf" $HOME/.tmux.conf &> /dev/null
  if [ $? = 0 ]; then
    echo "Already included $CURRENT_DIR/tmux.conf in $HOME/.tmux.conf"
  else
    echo "Including $CURRENT_DIR/tmux.conf in $HOME/.tmux.conf"
    echo "source-file $CURRENT_DIR/tmux.conf" >> $HOME/.tmux.conf
  fi
else
  echo "Creating $HOME/.tmux.conf and including $CURRENT_DIR/tmux.conf in it"
  touch $HOME/.tmux.conf
  echo "source-file $CURRENT_DIR/tmux.conf" >> $HOME/.tmux.conf
fi

$HOME/.tmux/plugins/tpm/bin/install_plugins

if [ -z "$ZSH_TMUX_AUTOSTART" ]; then
  echo "export ZSH_TMUX_AUTOSTART=true" >> $HOME/.zprofile
fi
