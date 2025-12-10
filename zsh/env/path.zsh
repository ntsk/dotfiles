export GOPATH=$HOME/go

typeset -gU cdpath fpath mailpath path

path=(
  $HOME/.nix-profile/bin
  /usr/local/{bin,sbin}
  $GOPATH/bin
  $HOME/.local/share/mise/shims
  $path
)

# Nix Home Manager session variables
if [[ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]]; then
  source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi

# Homebrew (Apple Silicon)
if [[ "$(uname -m)" == "arm64" ]] && [[ -f /opt/homebrew/bin/brew ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi
