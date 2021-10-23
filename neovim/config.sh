#!/bin/zsh

CURRENT_DIR=${0:A:h}

if [ -f "$HOME/.config/nvim/init.vim" ]; then
  grep "source $CURRENT_DIR/init.vim" $HOME/.config/nvim/init.vim &> /dev/null
  if [ $? = 0 ]; then
    echo "Already included $CURRENT_DIR/init.vim in $HOME/.config/nvim/init.vim"
  else
    echo "Including $CURRENT_DIR/init.vim in $HOME/.config/nvim/init.vim"
    echo "source $CURRENT_DIR/init.vim" >> $HOME/.config/nvim/init.vim
  fi
else
  echo "Creating $HOME/.config/nvim/init.vim and including $CURRENT_DIR/init.vim in it"
  echo "source $CURRENT_DIR/init.vim" >> $HOME/.config/nvim/init.vim
fi

nvim -es -u $CURRENT_DIR/init.vim -i NONE -c "PlugInstall" -c "qa"
nvim -es -u $CURRENT_DIR/init.vim -i NONE -c "TSUpdate" -c "qa"
