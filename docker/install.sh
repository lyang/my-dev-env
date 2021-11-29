#!/bin/zsh
set -o errexit

DISTRO=$(grep '^ID=' /etc/os-release | cut -d '=' -f 2 | tr -d "'\"")
DOCKER_COMPOSE_VERSION="v2.1.1"

if [ "$(command -v docker)" = "" ]; then
  curl -fsSL https://download.docker.com/linux/$DISTRO/gpg | sudo gpg --dearmor --output /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/$DISTRO $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
  sudo sh -c "
    apt-get update &&
    apt-get install -y docker-ce docker-ce-cli containerd.io &&
    usermod -a -G docker $(id -un) &&
    curl -fsSL 'https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)' -o /usr/libexec/docker/cli-plugins/docker-compose &&
    chmod +x /usr/libexec/docker/cli-plugins/docker-compose
  "
fi
