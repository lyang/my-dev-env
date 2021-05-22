#!/bin/bash

set -o nounset

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

FONTS=('Regular' 'Bold' 'Italic' 'Bold Italic')
for font in "${FONTS[@]}"
do
  wget "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS NF $font.ttf" -P $HOME/.local/share/fonts
done
fc-cache -fv

if [ -f "$HOME/.zshrc" ]; then
  grep "source $ROOT_DIR/zshrc" $HOME/.zshrc &> /dev/null
  if [ $? == 0 ]; then
    echo "Already included $ROOT_DIR/zshrc in $HOME/.zshrc"
  else
    echo "Including $ROOT_DIR/zshrc in $HOME/.zshrc"
    echo "source $ROOT_DIR/zshrc" >> $HOME/.zshrc
  fi
else
  echo "Creating $HOME/.zshrc and including $ROOT_DIR/zshrc in it"
  touch $HOME/.zshrc
  echo "source $ROOT_DIR/zshrc" >> $HOME/.zshrc
fi

if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo "Already installed powerlevel10k"
else
  git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
  echo "source $ROOT_DIR/p10k.zsh" > $HOME/.p10k.zsh
fi

sed -i 's/^ZSH_THEME.*$/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' $HOME/.zshrc
sed -i 's/^# HYPHEN_INSENSITIVE.*$/HYPHEN_INSENSITIVE="true"/g' $HOME/.zshrc
sed -i 's/^# ENABLE_CORRECTION.*$/ENABLE_CORRECTION="true"/g' $HOME/.zshrc
sed -i 's/^# HIST_STAMPS.*$/HIST_STAMPS="mm\/dd\/yyyy"/g' $HOME/.zshrc
