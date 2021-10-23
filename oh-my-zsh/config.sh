#!/bin/zsh

CURRENT_DIR=${0:A:h}

if [ -f "$HOME/.zshrc" ]; then
  grep "source $CURRENT_DIR/zshrc" $HOME/.zshrc &> /dev/null
  if [ $? = 0 ]; then
    echo "Already included $CURRENT_DIR/zshrc in $HOME/.zshrc"
  else
    echo "Including $CURRENT_DIR/zshrc in $HOME/.zshrc"
    echo "source $CURRENT_DIR/zshrc" >> $HOME/.zshrc
  fi
else
  echo "Creating $HOME/.zshrc"
  echo "source $CURRENT_DIR/zshrc" >> $HOME/.zshrc
fi

BACKUP_EXT=
if [ $(uname) = "Darwin" ]; then
  BACKUP_EXT="''"
fi

sed -i $BACKUP_EXT 's/^# ENABLE_CORRECTION.*$/ENABLE_CORRECTION="true"/g' $HOME/.oh-my-zsh.zshrc
sed -i $BACKUP_EXT 's/^# HIST_STAMPS.*$/HIST_STAMPS="mm\/dd\/yyyy"/g' $HOME/.oh-my-zsh.zshrc
sed -i $BACKUP_EXT 's/^# HYPHEN_INSENSITIVE.*$/HYPHEN_INSENSITIVE="true"/g' $HOME/.oh-my-zsh.zshrc
sed -i $BACKUP_EXT 's/^ZSH_THEME.*$/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' $HOME/.oh-my-zsh.zshrc
sed -i $BACKUP_EXT 's/^plugins=.*$/plugins=(git nvm pyenv rbenv tmux)/g' $HOME/.oh-my-zsh.zshrc

ln -fs $CURRENT_DIR/p10k.zsh $HOME/.p10k.zsh
