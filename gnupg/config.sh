#!/bin/zsh
set -o errexit

if [ $(uname) = "Darwin" ]; then
  if [ -f "$HOME/.gnupg/gpg-agent.conf" ]; then
    grep "pinentry-program" $HOME/.gnupg/gpg-agent.conf &> /dev/null
    if [ $? = 0 ]; then
      echo "Already setup pinentry-program in $HOME/.gnupg/gpg-agent.conf"
    else
      echo "Setting pinentry-program in $HOME/.gnupg/gpg-agent.conf"
      echo "pinentry-program /usr/local/bin/pinentry-mac" >> $HOME/.gnupg/gpg-agent.conf
    fi
  else
    echo "Creating $HOME/.gnupg/gpg-agent.conf and setting pinentry-program for it"
    echo "pinentry-program /usr/local/bin/pinentry-mac" >> $HOME/.gnupg/gpg-agent.conf
  fi
fi
