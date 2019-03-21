#!/bin/zsh

# Homebrew
if test ! "$(command -v brew)"; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade
brew bundle
brew cleanup

# Install prezto & prezto-prompt-simple
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
curl https://raw.githubusercontent.com/kami-zh/prezto-prompt-simple/master/prompt_simple_setup > ~/.zprezto/modules/prompt/functions/prompt_simple_setup

# Generate symlink
DOT_FILES=(.config .gitconfig .tigrc .peco)
echo "[Generate symlink]"
for file in ${DOT_FILES[@]}
  do
      ln -s $HOME/dotfiles/$file $HOME/$file
  done

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
