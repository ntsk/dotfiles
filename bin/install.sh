#!/bin/bash
set -eu

# This script is designed to be idempotent.
# It can be run multiple times safely without causing errors or duplicating setup.

DOTFILES_DIR=$HOME/dotfiles

echo "=== dotfiles setup ==="

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles..."
  git clone https://github.com/ntsk/dotfiles.git "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"
chmod -R +x bin

if [[ "$(uname -s)" == "Darwin" ]]; then
  echo ""
  echo "This script requires sudo access for nix-darwin."
  sudo -v
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

get_nix_system() {
  local arch=$(uname -m)
  local os=$(uname -s | tr '[:upper:]' '[:lower:]')
  case "$arch" in
    arm64) arch="aarch64" ;;
    x86_64) arch="x86_64" ;;
  esac
  echo "${arch}-${os}"
}

echo ""
echo "=== Installing Nix ==="
if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
elif ! command -v nix &> /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

echo ""
SYSTEM=$(get_nix_system)
# Save current user before sudo (sudo changes $USER to root)
CURRENT_USER="$USER"
if [[ "$(uname -s)" == "Darwin" ]]; then
  echo "=== Setting up nix-darwin + Home Manager ==="
  # nix-darwin requires root, but flake.nix uses $USER to determine the username
  # --impure allows builtins.getEnv to read environment variables
  # NIX_CONFIG: CI sets access-tokens to avoid GitHub API rate limit when fetching flakes
  sudo -n sh -c "export USER='$CURRENT_USER' NIX_CONFIG='${NIX_CONFIG:-}'; nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake '$DOTFILES_DIR/nix#${SYSTEM}' --impure"
else
  echo "=== Setting up Home Manager ==="
  # NIX_CONFIG: CI sets access-tokens to avoid GitHub API rate limit when fetching flakes
  NIX_CONFIG="${NIX_CONFIG:-}" nix run home-manager -- switch --flake "$DOTFILES_DIR/nix#${SYSTEM}" --impure
fi

echo ""
echo "=== Setup complete ==="
