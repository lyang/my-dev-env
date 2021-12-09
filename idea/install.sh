#!/bin/zsh

if [ "$(uname)" = "Darwin" ]; then
  brew install --cask intellij-idea-ce
  IDEA_VERSION=$(brew info --cask intellij-idea-ce | head -n1 | grep -oE '202[0-9]\.[0-9]+')
else
  IDEA_BUILD=2021.3
  IDEA_VERSION=$(echo $IDEA_BUILD | grep -oE '202[0-9]\.[0-9]+')
  IDEA_DIR="$HOME/.local/share/JetBrains/IdeaIC${IDEA_VERSION}"
  if [ ! -d $IDEA_DIR ]; then
    curl -fSL https://download.jetbrains.com/idea/ideaIC-$IDEA_BUILD.tar.gz --create-dir -o $IDEA_DIR/installer.tgz
    tar --strip-components=1 -xzf $IDEA_DIR/installer.tgz -C $IDEA_DIR && rm $IDEA_DIR/installer.tgz
    chmod -R a+rX $IDEA_DIR/bin/idea.sh
    mkdir -p $HOME/bin && ln -fs $IDEA_DIR/bin/idea.sh $HOME/bin/idea
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
