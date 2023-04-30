#!/bin/sh

set -eu

THIS_DIR=$(
  cd $(dirname $0)
  pwd
)

USER_REPO_ROOT=$HOME/go/src/github.com/ntsk

mkdir -p $USER_REPO_ROOT
if [ ! -d "$USER_REPO_ROOT/dotfiles" ]; then
  echo "Clone dotfile repository"
  git clone git@github.com:ntsk/dotfiles.git $USER_REPO_ROOT/dotfiles
else
  cd $USER_REPO_ROOT/dotfiles
  git pull origin master
fi

cd $USER_REPO_ROOT/dotfiles
chmod -R +x dotfiles/bin

cd $THIS_DIR
echo "Complete"
