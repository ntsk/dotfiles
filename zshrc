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
function gcopeco() {
  git checkout `git branch | peco | sed -e "s/\* //g" | awk "{print \$1}"`
}

# Search history
function select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle -R -c
}
zle -N select-history
bindkey '^r' select-history

# Nodejs
export PATH=$HOME/.nodebrew/current/bin:$PATH

# Android SDK
export PATH=$PATH:~/Library/Android/sdk/platform-tools

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

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
function adb-screen() {
  adb shell screencap -p /sdcard/screen.png
  adb pull /sdcard/screen.png ~/Desktop/$1
  adb shell rm /sdcard/screen.png
}

# adb install app
alias adb-install='find ./ -name *.apk | peco | xargs adb install -r'
alias adb-uninstall='adb shell pm list package | sed -e s/package:// | peco | xargs adb uninstall'

# adb open app
function adb-open() {
  package=`adb shell pm list package | sed -e s/package:// | peco`
  default_activity=`adb shell pm dump ${package} | grep -A 2 android.intent.action.MAIN | head -2 | tail -1 | awk '{print $2}'`
  adb shell am start -n ${default_activity}
}

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
