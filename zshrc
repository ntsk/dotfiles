# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

# NeoVim
export XDG_CONFIG_HOME="$HOME/dotfiles/.config"

# Replace vi with vim
alias vi='/usr/local/bin/nvim'

# History
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY

# Search repositories in ghq
alias repos='cd $(ghq root)/$(ghq list | peco)'

# Search branch & git checkout
function gcopeco () {
  git checkout `git branch | peco | sed -e "s/\* //g" | awk "{print \$1}"`
}

# Nodejs
export PATH=$HOME/.nodebrew/current/bin:$PATH

# Android SDK
export PATH=$PATH:~/Library/Android/sdk/platform-tools

# rbenv
PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# imagemagick
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"

# Flutter
export PATH=$HOME/flutter/bin:$PATH

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# ctags
alias ctags="`brew --prefix`/bin/ctags"

# peco find directory
function peco-find() {
  local current_buffer=$BUFFER
  local search_root=""
  local file_path=""

  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    search_root=`git rev-parse --show-toplevel`
  else
    search_root=`pwd`
  fi
  file_path="$(find ${search_root} -maxdepth 5 | peco)"
  BUFFER="${current_buffer} ${file_path}"
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-find

# bind keys
bindkey '^f' peco-find

# adb screenshot
function screenshot() {
  adb shell screencap -p /sdcard/screen.png
  adb pull /sdcard/screen.png ~/Desktop/$1
  adb shell rm /sdcard/screen.png
}

# go
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
