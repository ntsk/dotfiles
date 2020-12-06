#!/bin/zsh

# Homebrew
if test ! "$(command -v brew)"; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade
brew bundle --file $HOME/dotfiles/Brewfile
brew cleanup
