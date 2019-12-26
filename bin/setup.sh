#!/bin/bash
set -euxo pipefail

cd "$(dirname "$0")"

chmod -R +x ./bin

sh ./bin/install_homebrew.sh
sh ./bin/install_prezto.sh
sh ./bin/dotfiles_symlink.sh
sh ./bin/zsh_symlink.sh
