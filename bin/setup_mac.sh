#!/bin/bash
set -euxo pipefail

cd "$(dirname "$0")"

sh ./install_homebrew.sh
sh ./install_prezto.sh
sh ./dotfiles_symlink.sh
sh ./zsh_symlink.sh
