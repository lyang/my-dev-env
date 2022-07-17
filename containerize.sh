#!/bin/bash
set -o errexit
set -o nounset
set -o xtrace

CURRENT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
REPO_NAME=$(basename $CURRENT_DIR)
DISTRO=${1%:*}
TAG=${1#*:}
DOCKERFILE=$CURRENT_DIR/.generated/$DISTRO/$TAG/Dockerfile

USER_ID=$(id -u)
USER_NAME=$(id -un)

create-dockerfile() {
  mkdir -p $CURRENT_DIR/.generated/$DISTRO/$TAG
  rm -rf $DOCKERFILE
  write "FROM docker.io/$DISTRO:$TAG"
  write "ENV LANG=en_US.UTF-8"
  setup-for-$DISTRO
  write "RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen"
  write "RUN useradd -u $USER_ID -U -m $USER_NAME"
  write "RUN sed -i 's/^SHELL=\/bin\/sh/SHELL=\/usr\/bin\/zsh/g' /etc/default/useradd"
  write "RUN echo '$USER_NAME ALL=(root) NOPASSWD:ALL' >> /etc/sudoers.d/$USER_NAME"
  write "RUN chmod 0440 /etc/sudoers.d/$USER_NAME"
  write "USER $USER_NAME"
  write "WORKDIR /home/$USER_NAME"
  write "COPY --chown=$USER_NAME:$USER_NAME . $CURRENT_DIR"
  run-for-$DISTRO
  write "CMD [\"/usr/bin/zsh\", \"-l\"]"
}

setup-for-ubuntu() {
  setup-for-debian
}

run-for-ubuntu() {
  run-for-debian
}

setup-for-debian() {
  write "RUN apt-get update && apt-get install -y dbus locales sudo"
}

run-for-debian() {
  write "RUN dbus-run-session $CURRENT_DIR/setup.sh"
}

setup-for-fedora() {
  echo ""
}

run-for-fedora() {
  echo ""
}

write() {
  echo $1 >> $DOCKERFILE
}

create-dockerfile

docker build -f $DOCKERFILE -t localhost/my-dot-file-container:$DISTRO-$TAG $CURRENT_DIR
