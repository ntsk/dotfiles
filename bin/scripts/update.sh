#!/bin/bash
set -eu

DOTFILES_DIR=$HOME/dotfiles

nix --extra-experimental-features 'nix-command flakes' flake update --flake "$DOTFILES_DIR/nix"
