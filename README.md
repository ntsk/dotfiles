# dotfiles
![](https://github.com/ntsk/dotfiles/workflows/CI/badge.svg)

## Install
```
curl -sL https://raw.githubusercontent.com/ntsk/dotfiles/main/bin/install.sh | bash
```

This script will:
1. Clone or update the dotfiles repository
2. Install [Determinate Nix](https://docs.determinate.systems/determinate-nix/)
3. Apply configuration:
   - **macOS**: nix-darwin + Home Manager (system settings and user packages)
   - **Linux**: Home Manager only (user packages)

## Usage

After installation, the `dotfiles` command becomes available. You can restore your configuration anytime by running `dotfiles switch`.

```
dotfiles <command>
```

### Commands

- `dotfiles switch`: Apply configuration (runs darwin-rebuild/home-manager switch)
- `dotfiles update`: Update flake.lock (runs nix flake update)

## Package Management

- Core tools (neovim, tmux, ripgrep, fzf, etc.) are managed with [Nix](https://nixos.org/) for reproducible, cross-platform installation
- Config files (~/.zshrc, ~/.config/*, etc.) are managed via Home Manager
- Development languages (Node.js, Python, Go, etc.) are managed with [mise](https://mise.jdx.dev/) for simpler version switching across projects
