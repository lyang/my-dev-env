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
echo "ENV GIT_USER_NAME='$GIT_USER_NAME' GIT_USER_EMAIL='$GIT_USER_EMAIL'" >> $DOCKERFILE

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

echo "RUN echo 'source /home/$USER_NAME/.zshrc' >> /home/$USER_NAME/.zprofile" >> $DOCKERFILE
echo 'CMD ["/usr/bin/zsh", "-l"]' >> $DOCKERFILE

docker build -f $DOCKERFILE $CURRENT_DIR -t localhost/dev-env:latest

GPG_HOME="$(gpgconf --list-dir homedir)"

docker run -it \
  --env SSH_AUTH_SOCK \
  --env TZ=$(cat /etc/timezone) \
  --volume $GPG_HOME:$GPG_HOME \
  --volume $SSH_AUTH_SOCK:$SSH_AUTH_SOCK \
  --volume dev-env:/home/$USER_NAME/Code \
  localhost/dev-env:latest
