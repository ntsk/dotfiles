# gpg
export GPG_TTY=$(tty)

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# goenv
export PATH="$HOME/.goenv/bin:$PATH"
eval "$(goenv init -)"

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

# poetry
export PATH="$HOME/.poetry/bin:$PATH"

# nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# gcloud required python2
export CLOUDSDK_PYTHON=/Users/$USER/.pyenv/versions/2.7.15/bin/python2

# imagemagick
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"

# Flutter
export PATH=$HOME/flutter/bin:$PATH
export PATH="$PATH:/usr/lib/dart/bin"

# llvm
export PATH="/usr/local/opt/llvm/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

# linuxbrew
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Homebrew for Apple Silicon
if [[ "$(uname -m)" == "arm64" ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi
