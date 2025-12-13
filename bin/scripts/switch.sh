#!/bin/bash
set -eu

if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

DOTFILES_DIR=$HOME/dotfiles

get_nix_system() {
  local arch=$(uname -m)
  local os=$(uname -s | tr '[:upper:]' '[:lower:]')
  case "$arch" in
    arm64) arch="aarch64" ;;
    x86_64) arch="x86_64" ;;
  esac
  echo "${arch}-${os}"
}

SYSTEM=$(get_nix_system)
CURRENT_USER="$USER"

if [[ "$(uname -s)" == "Darwin" ]]; then
  sudo sh -c "export USER='$CURRENT_USER' NIX_CONFIG='${NIX_CONFIG:-}'; nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake '$DOTFILES_DIR/nix#${SYSTEM}' --impure"
else
  NIX_CONFIG="${NIX_CONFIG:-}" nix --extra-experimental-features 'nix-command flakes' run home-manager -- switch --flake "$DOTFILES_DIR/nix#${SYSTEM}" --impure
fi
