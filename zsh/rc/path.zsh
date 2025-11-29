# Nix
if [[ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]]; then
  source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi
export PATH="$HOME/.nix-profile/bin:$PATH"

# Homebrew for Apple Silicon
if [[ "$(uname -m)" == "arm64" ]] && [[ -f /opt/homebrew/bin/brew ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

# gpg
export GPG_TTY=$(tty)

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# mise
eval "$(mise activate zsh)"
