#!/bin/zsh

if [ "$(uname)" = "Darwin" ]; then
  brew install --cask intellij-idea-ce
  IDEA_VERSION=$(brew info --cask intellij-idea-ce | head -n1 | grep -oE '202[0-9]\.[0-9]+')
else
  IDEA_BUILD=2021.3
  IDEA_DIR="/opt/idea/$IDEA_BUILD"
  if [ ! -d "$IDEA_DIR" ]; then
    sudo sh -c "
      mkdir -p /opt/idea/bin $IDEA_DIR && chmod -R a+rX /opt/idea
      curl -sfLo $IDEA_DIR/installer.tgz https://download.jetbrains.com/idea/ideaIC-$IDEA_BUILD.tar.gz
      tar --strip-components=1 -xzf $IDEA_DIR/installer.tgz -C $IDEA_DIR && rm $IDEA_DIR/installer.tgz
      ln -fs $IDEA_DIR/bin/idea.sh /opt/idea/bin/idea
    "
  fi
  IDEA_VERSION=$(cat $IDEA_DIR/product-info.json | jq -r .version)

  grep '^export PATH=/opt/idea/bin:' /etc/zsh/zprofile &> /dev/null
  if [ $? != 0 ]; then
    sudo sh -c "echo 'export PATH=/opt/idea/bin:\$PATH' >> /etc/zsh/zprofile"
  fi
fi

BACKUP_EXT=
if [ $(uname) = "Darwin" ]; then
  BACKUP_EXT="''"
fi

grep "^export IDEA_VERSION=" $HOME/.zprofile &> /dev/null
if [ $? = 0 ]; then
  sed -i $BACKUP_EXT "s/^export IDEA_VERSION=.*$/export IDEA_VERSION='$IDEA_VERSION'/g" $HOME/.zprofile
else
  echo "export IDEA_VERSION='$IDEA_VERSION'" >> $HOME/.zprofile
fi
