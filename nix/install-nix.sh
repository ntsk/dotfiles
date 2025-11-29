#!/bin/bash
set -eu

echo "=== Installing Nix ==="
if ! command -v nix &> /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  echo "Please restart your shell and run this script again"
  exit 0
fi

get_system() {
  local arch=$(uname -m)
  local os=$(uname -s | tr '[:upper:]' '[:lower:]')

  case "$arch" in
    arm64) arch="aarch64" ;;
    x86_64) arch="x86_64" ;;
  esac

  echo "${arch}-${os}"
}

echo "=== Setting up Home Manager ==="
cd "$(dirname "$0")"
SYSTEM=$(get_system)
echo "Detected system: $SYSTEM"
nix run home-manager -- switch --flake ".#${SYSTEM}" --impure

echo "=== Nix setup complete ==="
