#!/bin/zsh

ZSH_FILES=(zlogin zlogout zpreztorc zprofile zshenv zshrc)
echo "[Setup zsh + prezto]"
if [ -e "$HOME/.zprezto/runcoms" ]; then
  for file in ${ZSH_FILES[@]}
    do
      rm -f $HOME/.zprezto/runcoms/$file
      ln -s $HOME/dotfiles/.zsh/$file $HOME/.zprezto/runcoms/$file
      ln -s $HOME/.zprezto/runcoms/$file $HOME/.$file
    done
else
  echo "Please install prezto before setup !"
fi
