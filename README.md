# dotfiles
![](https://github.com/ntsk/dotfiles/workflows/CI/badge.svg)

## Install
```
curl -sL https://raw.githubusercontent.com/ntsk/dotfiles/main/bin/install.sh | bash
```

This script will:
1. Clone or update the dotfiles repository
2. Install Nix
3. Apply configuration:
   - **macOS**: nix-darwin + Home Manager (system settings and user packages)
   - **Linux**: Home Manager only (user packages)

## Usage

After installation, the `dotfiles` command becomes available:

```
dotfiles <command>
```

### Commands

- `dotfiles switch`: Apply configuration (runs darwin-rebuild/home-manager switch)
- `dotfiles update`: Update flake.lock (runs nix flake update)

## Package Management

Core tools (neovim, tmux, ripgrep, fzf, etc.) are managed with Nix for reproducible, cross-platform installation. Config files are managed via Home Manager's `home.file` and `xdg.configFile`. Development languages and runtimes (Node.js, Python, Go, etc.) are managed with mise.
