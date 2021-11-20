#!/bin/zsh
set -o errexit

setup-Darwin() {
  echo "Setting up MacOS"

  if [[ $(command -v brew) == "" ]]; then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'export PATH="/usr/local/sbin:$PATH"' >> $HOME/.zprofile
    echo "alias brew='env PATH=\"\${PATH//\$(pyenv root)\/shims:/}\" brew'" >> $HOME/.zshrc
  else
    echo "Updating Homebrew"
    brew update
  fi

  FORMULAE=(
    buf
    curl
    htop
    jq
    mas
    openssl
    gnupg
    pinentry-mac
    podman
    ripgrep
    task
    wget
    zsh
  )
  brew install $FORMULAE

  CASKS=(
    docker
    iterm2
    rectangle
    stats
  )
  brew install --cask $CASKS
}

setup-Linux() {
  DISTRO=$(grep '^ID=' /etc/os-release | cut -d '=' -f 2 | tr -d "'\"")
  setup-$DISTRO
}

setup-ubuntu() {
  setup-debian
}

setup-debian() {
  PACKAGES=(
    acl
    automake
    autotools-dev
    bison
    gnupg
    hunspell
    less
    libbluetooth-dev
    libevent-dev
    locales
    man
    podman
    ripgrep
    taskwarrior
    tk-dev
    tree
    uuid-dev
    watch
    zip
    zsh
  )
  sudo apt-get update
  sudo apt-get install -y --no-install-recommends $PACKAGES
}

setup-$(uname)
