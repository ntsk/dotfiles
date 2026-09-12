#!/bin/bash
set -eu

if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
elif ! command -v nix &> /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf -L https://nixos.org/nix/install | NIX_INSTALLER_YES=1 sh -s -- --daemon
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi
