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
