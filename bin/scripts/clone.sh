#!/bin/bash
set -eu

DOTFILES_DIR=$HOME/dotfiles

if [ ! -d "$DOTFILES_DIR" ]; then
  git clone https://github.com/ntsk/dotfiles.git "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"
chmod -R +x bin
