#!/bin/bash
set -eu

# This script is designed to be idempotent.
# It can be run multiple times safely without causing errors or duplicating setup.

DOTFILES_DIR=$HOME/dotfiles
SCRIPTS_DIR="$DOTFILES_DIR/bin/scripts"

cat << 'EOF'
       __      __  _____ __
  ____/ /___  / /_/ __(_) /__  _____
 / __  / __ \/ __/ /_/ / / _ \/ ___/
/ /_/ / /_/ / /_/ __/ / /  __(__  )
\__,_/\____/\__/_/ /_/_/\___/____/

EOF

echo "🚀 Cloning dotfiles..."
"$SCRIPTS_DIR/clone.sh"

if [[ "$(uname -s)" == "Darwin" ]]; then
  echo ""
  echo "This script requires sudo access for nix-darwin."
  sudo -v
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

echo ""
echo "🚀 Installing Nix..."
"$SCRIPTS_DIR/install-nix.sh"

echo ""
if [[ "$(uname -s)" == "Darwin" ]]; then
  echo "🚀 Setting up nix-darwin + Home Manager..."
else
  echo "🚀 Setting up Home Manager..."
fi
"$SCRIPTS_DIR/switch.sh"

echo ""
echo "🚀 Setup complete!"
