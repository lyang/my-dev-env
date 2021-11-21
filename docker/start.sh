#!/bin/zsh

set -o errexit
set -o nounset
set -o xtrace

CURRENT_DIR=${0:A:h}
REPO_NAME=$(basename $(dirname $CURRENT_DIR))
USER_ID=$(id -u)
USER_NAME=$(id -un)
GIT_USER_NAME=$(git config --global user.name)
GIT_USER_EMAIL=$(git config --global user.email)

echo "FROM docker.io/buildpack-deps:bullseye" > $CURRENT_DIR/Dockerfile.generated
echo "RUN apt-get update && apt-get install -y --no-install-recommends locales sudo zsh" >> $CURRENT_DIR/Dockerfile.generated
echo "RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen" >> $CURRENT_DIR/Dockerfile.generated
echo "ENV LANG=en_US.UTF-8" >> $CURRENT_DIR/Dockerfile.generated
echo "RUN sed -i 's/^SHELL=\/bin\/sh/SHELL=\/usr\/bin\/zsh/g' /etc/default/useradd" >> $CURRENT_DIR/Dockerfile.generated
echo "RUN useradd -u $USER_ID -U -m $USER_NAME" >> $CURRENT_DIR/Dockerfile.generated
echo "RUN echo '$USER_NAME ALL=(root) NOPASSWD:ALL' >> /etc/sudoers.d/$USER_NAME" >> $CURRENT_DIR/Dockerfile.generated
echo "RUN chmod 0440 /etc/sudoers.d/$USER_NAME" >> $CURRENT_DIR/Dockerfile.generated
echo "WORKDIR /home/$USER_NAME" >> $CURRENT_DIR/Dockerfile.generated
echo "USER $USER_NAME" >> $CURRENT_DIR/Dockerfile.generated
echo "RUN mkdir -p $REPO_NAME" >> $CURRENT_DIR/Dockerfile.generated
echo "ENV GIT_USER_NAME='$GIT_USER_NAME' GIT_USER_EMAIL='$GIT_USER_EMAIL'" >> $CURRENT_DIR/Dockerfile.generated

for FILE_PATH in $(find $CURRENT_DIR/../* -type f -iname install.sh); do
  FILE_NAME=$(basename $FILE_PATH)
  DIR_NAME=$(basename $(dirname $FILE_PATH))
  echo "COPY --chown=$USER_NAME:$USER_NAME $DIR_NAME/$FILE_NAME $REPO_NAME/$DIR_NAME/$FILE_NAME" >> $CURRENT_DIR/Dockerfile.generated
  echo "RUN $REPO_NAME/$DIR_NAME/$FILE_NAME" >> $CURRENT_DIR/Dockerfile.generated
done

for FILE_PATH in $(find $CURRENT_DIR/../* -type f -iname config.sh); do
  FILE_NAME=$(basename $FILE_PATH)
  DIR_NAME=$(basename $(dirname $FILE_PATH))
  echo "COPY --chown=$USER_NAME:$USER_NAME $DIR_NAME $REPO_NAME/$DIR_NAME" >> $CURRENT_DIR/Dockerfile.generated
  echo "RUN /usr/bin/zsh -lc $REPO_NAME/$DIR_NAME/$FILE_NAME" >> $CURRENT_DIR/Dockerfile.generated
done

echo "RUN echo 'source /home/$USER_NAME/.zshrc' >> /home/$USER_NAME/.zprofile" >> $CURRENT_DIR/Dockerfile.generated
echo 'CMD ["/usr/bin/zsh", "-l"]' >> $CURRENT_DIR/Dockerfile.generated

docker build -f $CURRENT_DIR/Dockerfile.generated $CURRENT_DIR/.. -t dev-env && docker run -it dev-env
