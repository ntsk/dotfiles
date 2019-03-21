#!/bin/zsh

DOT_FILES=(.gitconfig .tigrc .peco)
for file in ${DOT_FILES[@]}
  do
      ln -s $HOME/dotfiles/$file $HOME/$file
  done

