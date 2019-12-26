#!/bin/bash
set -euxo pipefail

sh ./bin/install_homebrew.sh
sh ./bin/install_prezto.sh
sh ./bin/dotfiles_symlink.sh
sh ./bin/zsh_symlink.sh
