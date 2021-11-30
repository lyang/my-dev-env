#!/bin/zsh

CURRENT_DIR=${0:A:h}

SIGNING_KEY_ID=$(gpg --keyid-format LONG -K $GIT_USER_EMAIL | grep sec | sed 's/^.*\/\([^ ]*\) .*/\1/' || "")

if [ -n "$SIGNING_KEY_ID" ]; then
  git config --global user.signingkey $SIGNING_KEY_ID
  git config --global commit.gpgsign true
  echo "Code Signing Key Found: $SIGNING_KEY_ID"
else
  git config --global --unset user.signingkey
  git config --global --unset commit.gpgsign
  echo "Code Signing Key Not Found"
fi

if [ -f "$HOME/.gitconfig" ]; then
  git config --global --get-all --type=path include.path | grep $CURRENT_DIR/gitconfig &> /dev/null
  if [ $? = 0 ]; then
    echo "Already included $CURRENT_DIR/gitconfig in $HOME/.gitconfig"
  else
    echo "Including $CURRENT_DIR/gitconfig in $HOME/.gitconfig"
    git config --global --type=path --add include.path $CURRENT_DIR/gitconfig
  fi
else
  echo "Creating $HOME/.gitconfig and including $CURRENT_DIR/gitconfig in it"
  touch $HOME/.gitconfig
  git config --global --type=path --add include.path $CURRENT_DIR/gitconfig
  git config --global user.name $GIT_USER_NAME
  git config --global user.email $GIT_USER_EMAIL
fi
