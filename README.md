# dotfiles
![](https://github.com/ntsk/dotfiles/workflows/CI/badge.svg)

## Install
```
curl -sL https://raw.githubusercontent.com/ntsk/dotfiles/main/bin/install.sh | bash
```

This script will:
1. Clone or update the dotfiles repository
2. Install Nix and Home Manager
3. Install packages via Nix (cross-platform: macOS/Linux)
4. Install Prezto and prezto-prompt-simple theme
5. Create symlinks for config files
