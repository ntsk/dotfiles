# dotfiles
![](https://github.com/ntsk/dotfiles/workflows/CI/badge.svg)

## Install
```
curl -sL https://raw.githubusercontent.com/ntsk/dotfiles/main/bin/install.sh | bash
```

This script will:
1. Clone or update the dotfiles repository
2. Install Nix and Home Manager
3. Install packages and create config symlinks via Home Manager

## Package Management

Core tools (neovim, tmux, ripgrep, fzf, etc.) are managed with Nix for reproducible, cross-platform installation. Config files are managed via Home Manager's `home.file` and `xdg.configFile`. Development languages and runtimes (Node.js, Python, Go, etc.) are managed with mise.
