#!/bin/zsh
set -o errexit

CURRENT_DIR=${0:A:h}

if [ -d "$HOME/.oh-my-zsh" ]; then
  git -C $HOME/.oh-my-zsh pull
else
  git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
fi
cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.oh-my-zsh.zshrc

if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  git -C $HOME/.oh-my-zsh/custom/themes/powerlevel10k pull
else
  git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi
