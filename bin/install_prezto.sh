#!/bin/zsh

# Install prezto & prezto-prompt-simple
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
curl -k https://raw.githubusercontent.com/kami-zh/prezto-prompt-simple/master/prompt_simple_setup > ~/.zprezto/modules/prompt/functions/prompt_simple_setup
