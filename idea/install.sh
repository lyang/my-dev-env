#!/bin/zsh
set -o errexit

if [ "$(uname)" = "Darwin" ]; then
  brew install --cask intellij-idea-ce
else
  IDEA_BUILD=2021.2.2
  IDEA_DIR="$HOME/.local/share/JetBrains/IdeaIC${IDEA_BUILD:r}"
  if [ ! -d $IDEA_DIR ]; then
    curl -fSL https://download.jetbrains.com/idea/ideaIC-$IDEA_BUILD.tar.gz --create-dir -o $IDEA_DIR/installer.tgz
    tar --strip-components=1 -xzf $IDEA_DIR/installer.tgz -C $IDEA_DIR && rm $IDEA_DIR/installer.tgz
    chmod -R a+rX $IDEA_DIR/bin/idea.sh
    mkdir -p $HOME/bin && ln -fs $IDEA_DIR/bin/idea.sh $HOME/bin/idea
  fi
fi
