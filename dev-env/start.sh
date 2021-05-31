#!/bin/bash

set -o errexit
ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
export TZ=$(cat /etc/timezone)
export TIMESTAMP=$(date +%Y%m%d%H%M%S)
ARGS="-f $ROOT_DIR/docker-compose.yml"

if [ -z "$DEV_ENV" ]; then
  export DOCKER_SOCK="/var/run/docker.sock"
  export GPG_AGENT_SOCK="$(gpgconf --list-dir agent-socket)"
  export X11_SOCK="/tmp/.X11-unix"
  ARGS="$ARGS -f $ROOT_DIR/docker-compose.empowered.yml"
fi

docker-compose $ARGS run dev-env
