#!/bin/bash
set -eu

if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
elif ! command -v nix &> /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf -L https://nixos.org/nix/install | NIX_INSTALLER_YES=1 sh -s -- --daemon

  if [[ "$(uname -s)" == "Darwin" ]]; then
    for f in /etc/bashrc /etc/zshrc; do
      if [ -e "$f" ]; then
        sudo mv "$f" "$f.before-nix-darwin"
      fi
    done
  fi

  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi
