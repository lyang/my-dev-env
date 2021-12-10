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
    fswatch
    htop
    jq
    mas
    openssl
    gnupg
    pinentry-mac
    podman
    ripgrep
    task
    tmux
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
    build-essential
    ca-certificates
    curl
    fswatch
    fuse-overlayfs
    gnupg
    hunspell
    jq
    less
    libbluetooth-dev
    libbz2-dev
    libevent-dev
    libffi-dev
    liblzma-dev
    libncursesw5-dev
    libreadline-dev
    libsqlite3-dev
    libssl-dev
    libxml2-dev
    libxmlsec1-dev
    libxtst6
    llvm
    locales
    lsb-release
    man
    podman
    ripgrep
    slirp4netns
    taskwarrior
    tk-dev
    tmux
    tree
    uidmap
    uuid-dev
    watch
    wget
    xz-utils
    zip
    zlib1g-dev
    zsh
  )
  sudo apt-get update
  sudo apt-get install -y --no-install-recommends $PACKAGES
}

setup-$(uname)
