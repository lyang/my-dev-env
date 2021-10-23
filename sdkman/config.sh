#!/bin/bash
set -o errexit

source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk install java 17-open
sdk install maven
sdk install gradle
