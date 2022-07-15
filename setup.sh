#!/bin/bash
set -o errexit

CURRENT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

setup() {
  setup-$(uname)
  ansible-galaxy collection install community.general
  ansible-playbook $CURRENT_DIR/playbook.yaml --inventory $CURRENT_DIR/inventory.yaml
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

setup
echo 'Setup finished. Please restart your terminal'
