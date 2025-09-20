# gpg
export GPG_TTY=$(tty)

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# mise
eval "$(mise activate zsh)"

# poetry
export PATH="$HOME/.poetry/bin:$PATH"

# imagemagick
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"

# Flutter
export PATH=$HOME/flutter/bin:$PATH
export PATH="$PATH:/usr/lib/dart/bin"

# deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Homebrew for Apple Silicon
if [[ "$(uname -m)" == "arm64" ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi
