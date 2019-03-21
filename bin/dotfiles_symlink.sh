#!/bin/zsh

# Generate symlink
DOT_FILES=(.gitconfig .tigrc .peco)
echo "[Generate symlink]"
for file in ${DOT_FILES[@]}
  do
      ln -s $HOME/dotfiles/$file $HOME/$file
  done

