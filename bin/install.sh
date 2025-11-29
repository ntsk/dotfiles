#!/bin/bash
set -eu

DOTFILES_DIR=$HOME/dotfiles

echo "=== dotfiles setup ==="

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles..."
  git clone https://github.com/ntsk/dotfiles.git "$DOTFILES_DIR"
else
  echo "Updating dotfiles..."
  cd "$DOTFILES_DIR"
  git pull origin main
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
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  echo "Nix installed. Please restart your shell and run this script again."
  exit 0
fi

echo ""
echo "=== Setting up Home Manager ==="
SYSTEM=$(get_nix_system)
nix run home-manager -- switch --flake "$DOTFILES_DIR/nix#${SYSTEM}" --impure

echo ""
echo "=== Setting up Zsh (Prezto) ==="
if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
else
  echo "Prezto already installed"
fi

if [ ! -f "$HOME/.zprezto/modules/prompt/functions/prompt_simple_setup" ]; then
  curl -ksS https://raw.githubusercontent.com/kami-zh/prezto-prompt-simple/master/prompt_simple_setup > "$HOME/.zprezto/modules/prompt/functions/prompt_simple_setup"
else
  echo "prezto-prompt-simple already installed"
fi

ZSH_FILES=(zlogin zlogout zpreztorc zprofile zshenv zshrc)
if [ -d "$HOME/.zprezto/runcoms" ]; then
  for file in "${ZSH_FILES[@]}"; do
    rm -f "$HOME/.zprezto/runcoms/$file"
    ln -sf "$DOTFILES_DIR/zsh/$file" "$HOME/.zprezto/runcoms/$file"
    ln -sf "$HOME/.zprezto/runcoms/$file" "$HOME/.$file"
  done
fi

echo ""
echo "=== Creating symlinks ==="
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/.tigrc" "$HOME/.tigrc"
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/.ctags" "$HOME/.ctags"
ln -sf "$DOTFILES_DIR/peco" "$HOME/.peco"
ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
ln -sf "$DOTFILES_DIR/wezterm" "$HOME/.config/wezterm"

if [ -d "$HOME/.claude" ]; then
  ln -sf "$DOTFILES_DIR/.claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
  ln -sf "$DOTFILES_DIR/.claude/settings.json" "$HOME/.claude/settings.json"
else
  ln -sf "$DOTFILES_DIR/.claude" "$HOME/.claude"
fi

echo ""
echo "=== Setup complete ==="
