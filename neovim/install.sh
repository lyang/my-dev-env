#!/bin/zsh

if [ "$(uname)" = "Darwin" ]; then
  brew install neovim
else
  NVIM_BUILD="v0.7.0"
  NVIM_DIR="/opt/nvim/$NVIM_BUILD"
  if [ ! -d "$NVIM_DIR" ]; then
    sudo sh -c "
      mkdir -p /opt/nvim/bin $NVIM_DIR && chmod -R a+rX /opt/nvim
      curl -sfLo $NVIM_DIR/nvim.appimage https://github.com/neovim/neovim/releases/download/$NVIM_BUILD/nvim.appimage
      chmod u+x $NVIM_DIR/nvim.appimage && cd $NVIM_DIR && $NVIM_DIR/nvim.appimage --appimage-extract
      ln -fs $NVIM_DIR/squashfs-root/AppRun /opt/nvim/bin/nvim
    "
  fi

  grep '^export PATH=/opt/nvim/bin:' /etc/zsh/zprofile &> /dev/null
  if [ $? != 0 ]; then
    sudo sh -c "echo 'export PATH=/opt/nvim/bin:\$PATH' >> /etc/zsh/zprofile"
  fi
fi
