#!/bin/bash
set -o errexit

CURRENT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

setup() {
  setup-$(uname)
  ansible-galaxy collection install community.general
  if sudo --non-interactive true 2> /dev/null; then
    ANSIBLE_OPTIONS=""
  else
    ANSIBLE_OPTIONS="--ask-become-pass"
  fi
  ansible-playbook $CURRENT_DIR/playbook.yaml --inventory $CURRENT_DIR/inventory.yaml $ANSIBLE_OPTIONS
}

setup-Linux() {
  DISTRO=$(grep '^ID=' /etc/os-release | cut -d '=' -f 2 | tr -d "'\"")
  echo "Setting up $DISTRO"
  setup-$DISTRO
}

setup-ubuntu() {
  setup-debian
}

setup-debian() {
  sudo apt-get update
  sudo apt-get install -y --no-install-recommends ansible
}

setup-fedora() {
  sudo dnf install --refresh --assumeyes ansible
}

setup-Darwin() {
  echo "Setting up Darwin"
  setup-rosetta
  setup-xcode
  setup-homebrew
  brew install ansible
}

setup-rosetta() {
  if [[ $(uname -m) == "arm64" ]]; then
    echo "Installing Rosetta for Apple silicon"
    softwareupdate --install-rosetta --agree-to-license
  else
    echo "No need for Rosetta"
  fi
}

setup-xcode() {
  if xcode-select --install 2>&1 | grep installed &>/dev/null; then
    echo "XCode already installed"
  fi
}

setup-homebrew() {
  if [[ $(command -v brew) == "" ]]; then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    brew update
  fi
}

setup
echo 'Setup finished. Please restart your terminal'
