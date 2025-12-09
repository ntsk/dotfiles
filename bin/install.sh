#!/bin/bash
set -eu

DOTFILES_DIR=$HOME/dotfiles

echo "=== dotfiles setup ==="

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles..."
  git clone https://github.com/ntsk/dotfiles.git "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"
chmod -R +x bin

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
if ! command -v nix &> /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

echo ""
if [[ "$(uname -s)" == "Darwin" ]]; then
  echo "=== Setting up nix-darwin + Home Manager ==="
  sudo -H nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake "$DOTFILES_DIR/nix#ntsk"
else
  echo "=== Setting up Home Manager ==="
  SYSTEM=$(get_nix_system)
  nix run home-manager -- switch --flake "$DOTFILES_DIR/nix#${SYSTEM}" --impure
fi

echo ""
echo "=== Setup complete ==="
