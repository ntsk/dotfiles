#!/bin/sh

set -eu

DOTFILES_DIR=$HOME/dotfiles

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Clone dotfile repository"
  git clone https://github.com/ntsk/dotfiles.git $DOTFILES_DIR
else
  cd $DOTFILES_DIR
  git pull origin master
fi

cd $DOTFILES_DIR
chmod -R +x bin

echo "Complete"
