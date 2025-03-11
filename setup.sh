#!/bin/bash
set -o errexit

CURRENT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
PLAYBOOK=$CURRENT_DIR/playbook.yaml
INVENTORY=$CURRENT_DIR/inventory.yaml

setup() {
  setup-"$(uname)"
  setup-homebrew
  setup-ansible
  generate-playbook
  run-playbook "$@"
}

setup-Linux() {
  HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
  DISTRO=$(grep '^ID=' /etc/os-release | cut -d '=' -f 2 | tr -d "'\"")
  echo "Setting up $DISTRO"
  setup-"$DISTRO"
}

setup-ubuntu() {
  setup-debian
}

setup-debian() {
  sudo apt-get update
  sudo apt-get install -y --no-install-recommends build-essential procps curl file git ca-certificates
}

setup-fedora() {
  sudo dnf install --refresh --assumeyes @development-tools procps-ng curl file git python3-libdnf5
}

setup-Darwin() {
  HOMEBREW_PREFIX="/opt/homebrew"
  echo "Setting up Darwin"
  setup-rosetta
  setup-xcode
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
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    BREW_SHELL_ENV=$("$HOMEBREW_PREFIX"/bin/brew shellenv)
    eval "$BREW_SHELL_ENV"
  else
    brew update
  fi
}

setup-ansible() {
  brew install ansible
  ansible-galaxy collection install community.general
}

generate-playbook() {
  echo "- hosts: localhost" > "$PLAYBOOK"
  echo "  roles:" >> "$PLAYBOOK"
  find "$CURRENT_DIR/roles" -maxdepth 1 -mindepth 1 -type d -print0 | sort --zero-terminated | while IFS= read -r -d $'\0' role; do
    role_name=$(basename "$role")
    echo "    - role: $role_name" >> "$PLAYBOOK"
    echo "      tags: [$role_name]" >> "$PLAYBOOK"
  done
}

run-playbook() {
  ANSIBLE_OPTIONS=("${@}")
  if ! sudo --non-interactive true 2> /dev/null; then
    ANSIBLE_OPTIONS+=("--ask-become-pass")
  fi
  ansible-playbook "$PLAYBOOK" --inventory "$INVENTORY" "${ANSIBLE_OPTIONS[@]}"
}

setup "$@"

echo 'Setup finished. Please restart your terminal'
