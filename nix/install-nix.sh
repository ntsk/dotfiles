#!/bin/bash
set -eu

echo "=== Installing Nix ==="
if ! command -v nix &> /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  echo "Please restart your shell and run this script again"
  exit 0
fi

echo "=== Setting up Home Manager ==="
cd "$(dirname "$0")"
nix run home-manager -- switch --flake .#$(uname -m)-$(uname -s | tr '[:upper:]' '[:lower:]')

echo "=== Nix setup complete ==="
