# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

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

# gcloud required python2
export CLOUDSDK_PYTHON=/Users/$USER/.pyenv/versions/2.7.15/bin/python2

# imagemagick
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"

# Flutter
export PATH=$HOME/flutter/bin:$PATH

# Nodejs
export PATH=$HOME/.nodebrew/current/bin:$PATH

# binutils
export PATH=/usr/local/opt/binutils/bin:$PATH
export LDFLAGS="-L/usr/local/opt/binutils/lib"
export CPPFLAGS="-I/usr/local/opt/binutils/include"

