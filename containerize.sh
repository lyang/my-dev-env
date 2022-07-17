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
  base-package-for-$DISTRO
  locale-for-$DISTRO
  write "RUN useradd -u $USER_ID -U -m $USER_NAME"
  write "RUN sed -i 's/^SHELL=\/bin\/sh/SHELL=\/usr\/bin\/zsh/g' /etc/default/useradd"
  write "RUN echo '$USER_NAME ALL=(root) NOPASSWD:ALL' >> /etc/sudoers.d/$USER_NAME"
  write "RUN chmod 0440 /etc/sudoers.d/$USER_NAME"
  write "USER $USER_NAME"
  write "WORKDIR /home/$USER_NAME"
  write "COPY --chown=$USER_NAME:$USER_NAME . $CURRENT_DIR"
  write "RUN dbus-run-session $CURRENT_DIR/setup.sh"
}

base-package-for-ubuntu() {
  base-package-for-debian
}

locale-for-ubuntu() {
  locale-for-debian
}

base-package-for-debian() {
  write "RUN apt-get update && apt-get install -y dbus locales sudo"
}

locale-for-debian() {
  write "RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen"
}

base-package-for-fedora() {
  write "RUN dnf install --assumeyes glibc-locale-source glibc-langpack-en dbus-daemon"
}

locale-for-fedora() {
  write "RUN localedef -i en_US -f UTF-8 en_US.UTF-8"
}

write() {
  echo $1 >> $DOCKERFILE
}

create-dockerfile

docker build -f $DOCKERFILE -t localhost/my-dot-file-container:$DISTRO-$TAG $CURRENT_DIR

