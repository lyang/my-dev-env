#!/bin/bash

set -o errexit
set -o nounset

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

FONTS=('Regular' 'Bold' 'Italic' 'Bold Italic')
for font in "${FONTS[@]}"
do
  wget "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS NF $font.ttf" -P $HOME/.local/share/fonts
done
fc-cache -fv

if [ -f "$HOME/.zshrc" ]; then
  echo "Backing up previous $HOME/.zshrc to $HOME/.zshrc.backup"
  mv $HOME/.zshrc $HOME/.zshrc.backup
fi

if [ -f "$HOME/.p10k.zsh" ]; then
  echo "Backing up previous $HOME/.p10k.zsh to $HOME/.p10k.zsh.backup"
  mv $HOME/.p10k.zsh $HOME/.p10k.zsh.backup
fi

echo "source $ROOT_DIR/zshrc" > $HOME/.zshrc
echo "source $ROOT_DIR/p10k.zsh" > $HOME/.p10k.zsh
