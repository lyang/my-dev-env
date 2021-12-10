#!/bin/zsh

set -o errexit
set -o nounset
set -o xtrace

CURRENT_DIR=${0:A:h}
REPO_NAME=$(basename $CURRENT_DIR)
DOCKERFILE=$CURRENT_DIR/.generated/Dockerfile

USER_ID=$(id -u)
USER_NAME=$(id -un)
GIT_USER_NAME=$(git config --global user.name)
GIT_USER_EMAIL=$(git config --global user.email)
GIT_USER_SIGNINGKEY=$(git config --global user.signingkey)

echo "FROM docker.io/buildpack-deps:bullseye" > $DOCKERFILE
echo "RUN apt-get update && apt-get install -y --no-install-recommends locales sudo zsh" >> $DOCKERFILE
echo "RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen" >> $DOCKERFILE
echo "ENV LANG=en_US.UTF-8" >> $DOCKERFILE
echo "RUN sed -i 's/^SHELL=\/bin\/sh/SHELL=\/usr\/bin\/zsh/g' /etc/default/useradd" >> $DOCKERFILE
echo "RUN useradd -u $USER_ID -U -m $USER_NAME" >> $DOCKERFILE
echo "RUN echo '$USER_NAME ALL=(root) NOPASSWD:ALL' >> /etc/sudoers.d/$USER_NAME" >> $DOCKERFILE
echo "RUN chmod 0440 /etc/sudoers.d/$USER_NAME" >> $DOCKERFILE
echo "WORKDIR /home/$USER_NAME" >> $DOCKERFILE
echo "USER $USER_NAME" >> $DOCKERFILE
echo "RUN mkdir -p $REPO_NAME" >> $DOCKERFILE
echo "ENV GIT_USER_NAME='$GIT_USER_NAME'" >> $DOCKERFILE
echo "ENV GIT_USER_EMAIL='$GIT_USER_EMAIL'" >> $DOCKERFILE

if [ -n "${GIT_USER_SIGNINGKEY}" ]; then
  echo "ENV GIT_USER_SIGNINGKEY='$GIT_USER_SIGNINGKEY'" >> $DOCKERFILE
fi

for FILE_PATH in $(find $CURRENT_DIR/* -type f -iname install.sh); do
  FILE_NAME=$(basename $FILE_PATH)
  DIR_NAME=$(basename $(dirname $FILE_PATH))
  echo "COPY --chown=$USER_NAME:$USER_NAME $DIR_NAME/$FILE_NAME $REPO_NAME/$DIR_NAME/$FILE_NAME" >> $DOCKERFILE
  echo "RUN $REPO_NAME/$DIR_NAME/$FILE_NAME" >> $DOCKERFILE
done

for FILE_PATH in $(find $CURRENT_DIR/* -type f -iname config.sh); do
  FILE_NAME=$(basename $FILE_PATH)
  DIR_NAME=$(basename $(dirname $FILE_PATH))
  echo "COPY --chown=$USER_NAME:$USER_NAME $DIR_NAME $REPO_NAME/$DIR_NAME" >> $DOCKERFILE
  echo "RUN /usr/bin/zsh -lc $REPO_NAME/$DIR_NAME/$FILE_NAME" >> $DOCKERFILE
done

if [ -n "${GIT_USER_SIGNINGKEY}" ]; then
  GPG_KEY="$GIT_USER_SIGNINGKEY.key"
  GPG_TRUST="$GIT_USER_SIGNINGKEY.trust"
  gpg --export --armor $GIT_USER_SIGNINGKEY > $CURRENT_DIR/.generated/gnupg/$GPG_KEY
  gpg --export-ownertrust | grep $GIT_USER_SIGNINGKEY > $CURRENT_DIR/.generated/gnupg/$GPG_TRUST
  echo "COPY --chown=$USER_NAME:$USER_NAME .generated/gnupg /home/$USER_NAME/.gnupg" >> $DOCKERFILE
  echo "RUN gpg --import /home/$USER_NAME/.gnupg/$GPG_KEY" >> $DOCKERFILE
  echo "RUN gpg --import-ownertrust /home/$USER_NAME/.gnupg/$GPG_TRUST" >> $DOCKERFILE
fi

echo 'CMD ["/usr/bin/zsh", "-l"]' >> $DOCKERFILE

docker build -f $DOCKERFILE $CURRENT_DIR -t localhost/my-dot-file-container:latest

GPG_AGENT_SOCK="$(gpgconf --list-dir agent-extra-socket)"

docker run -it \
  --env DISPLAY \
  --env SSH_AUTH_SOCK \
  --env TZ=$(cat /etc/timezone) \
  --hostname my-dot-file-container \
  --volume $GPG_AGENT_SOCK:/home/$USER_NAME/.gnupg/S.gpg-agent \
  --volume $SSH_AUTH_SOCK:$SSH_AUTH_SOCK \
  --volume $XAUTHORITY:$XAUTHORITY \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  --volume dev-env:/home/$USER_NAME/Code \
  localhost/my-dot-file-container:latest
