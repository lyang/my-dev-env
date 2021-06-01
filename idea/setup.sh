#!/bin/zsh

set -o nounset

ROOT_DIR=$(cd "$(dirname "${(%):-%N}")" && pwd)
JETBRAINS_DIR="$HOME/.local/share/JetBrains"
IDEA_DIR="$JETBRAINS_DIR/IdeaIC${IDEA_BUILD:r}"

if [ -f "$HOME/.ideavimrc" ]; then
  grep "source $ROOT_DIR/idea.vim" $HOME/.ideavimrc &> /dev/null
  if [ $? = 0 ]; then
    echo "Already included $ROOT_DIR/idea.vim in $HOME/.ideavimrc"
  else
    echo "Including $ROOT_DIR/idea.vim in $HOME/.ideavimrc"
    echo "source $ROOT_DIR/idea.vim" >> $HOME/.ideavimrc
  fi
else
  echo "Creating $HOME/.ideavimrc and including $ROOT_DIR/idea.vim in it"
  echo "source $ROOT_DIR/idea.vim" >> $HOME/.ideavimrc
fi

declare -A plugins
plugins["AceJump"]=119931
plugins["Docker"]=117745
plugins["IdeaVIM"]=120141
plugins["KeyPromoterX"]=113404
plugins["google-java-format"]=115960

mkdir -p $IDEA_DIR

for name id in "${(@kv)plugins}"; do
  curl -fSL "https://plugins.jetbrains.com/plugin/download?rel=true&updateId=$id" -o "$IDEA_DIR/$name.zip"
  unzip "$IDEA_DIR/$name.zip" -d "$IDEA_DIR" && rm "$IDEA_DIR/$name.zip"
done
