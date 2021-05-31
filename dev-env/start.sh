#!/bin/bash

set -o errexit
ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
TZ=$(cat /etc/timezone)
TIMESTAMP=$(date +%Y%m%d%H%M%S)

docker build --pull -t linyang1218/dev-env:lyang $ROOT_DIR
ARGS="-it --env DEV_ENV=true --env TERM=$TERM --env TZ=$TZ --name dev-env-$TIMESTAMP"

if [ -z "$DEV_ENV" ]; then
  DOCKER_SOCK="--volume /var/run/docker.sock:/var/run/docker.sock"
  GPG_SOCK="--volume $(gpgconf --list-dir agent-extra-socket):/home/gnupg/S.gpg-agent"
  SSH_SOCK="--volume $SSH_AUTH_SOCK:$SSH_AUTH_SOCK --env SSH_AUTH_SOCK"
  ARGS="$ARGS $DOCKER_SOCK $GPG_SOCK $SSH_SOCK"
fi
docker run $ARGS linyang1218/dev-env:lyang $@
