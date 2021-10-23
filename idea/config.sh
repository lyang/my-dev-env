#!/bin/zsh
set -o errexit
set -o nounset

CURRENT_DIR=${0:A:h}

if [ -f "$HOME/.ideavimrc" ]; then
  grep "source $CURRENT_DIR/idea.vim" $HOME/.ideavimrc &> /dev/null
  if [ $? = 0 ]; then
    echo "Already included $CURRENT_DIR/idea.vim in $HOME/.ideavimrc"
  else
    echo "Including $CURRENT_DIR/idea.vim in $HOME/.ideavimrc"
    echo "source $CURRENT_DIR/idea.vim" >> $HOME/.ideavimrc
  fi
else
  echo "Creating $HOME/.ideavimrc and including $CURRENT_DIR/idea.vim in it"
  echo "source $CURRENT_DIR/idea.vim" >> $HOME/.ideavimrc
fi

if [ $(uname) = "Darwin" ]; then
  IDEA_BUILD=$(brew info --cask intellij-idea-ce | head -n1 | grep -oE '202[0-9.]+')
  IDEA_DIR="$HOME/Library/Application Support/JetBrains/IdeaIC${IDEA_BUILD:r}/plugins"
else
  IDEA_DIR="$HOME/.local/share/JetBrains/IdeaIC2021.2/plugins"
fi

declare -A plugins
plugins[AceJump]=119931
plugins[Docker]=136123
plugins[IdeaVIM]=137477
plugins[Key-Promoter-X]=130615
plugins[google-java-format]=115960

mkdir -p $IDEA_DIR

for name id in "${(@kv)plugins}"; do
  if [ ! -d "$IDEA_DIR/$name" ]; then
    curl -fSL "https://plugins.jetbrains.com/plugin/download?rel=true&updateId=$id" -o "$IDEA_DIR/$name.zip"
    unzip -u "$IDEA_DIR/$name.zip" -d "$IDEA_DIR" && rm "$IDEA_DIR/$name.zip"
  fi
done
