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
  git pull origin master
fi

cd "$DOTFILES_DIR"
chmod -R +x bin

OS="$(uname -s)"
case "$OS" in
  Darwin)
    echo ""
    echo "=== Installing Homebrew packages ==="
    if ! command -v brew &> /dev/null; then
      echo "Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    brew bundle --file "$DOTFILES_DIR/Brewfile" --no-lock
    ;;
  Linux)
    if command -v pacman &> /dev/null; then
      echo ""
      echo "=== Installing pacman packages ==="
      sudo pacman -S --needed --noconfirm $(comm -12 <(pacman -Slq | sort) <(sort "$DOTFILES_DIR/Pacfile"))
    fi
    ;;
esac

echo ""
echo "=== Setting up Zsh (Prezto) ==="
if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
  echo "Cloning Prezto..."
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
else
  echo "Prezto already installed"
fi

if [ ! -f "$HOME/.zprezto/modules/prompt/functions/prompt_simple_setup" ]; then
  echo "Installing prezto-prompt-simple..."
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
  echo "Zsh symlinks created"
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

echo "Symlinks created"

echo ""
echo "=== Setup complete ==="
