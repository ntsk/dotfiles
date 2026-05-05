# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Personal dotfiles repository managed with Nix flakes. macOS uses `nix-darwin` + `home-manager`; Linux uses `home-manager` only.

## `dotfiles` command

After installation, a `dotfiles` shell function is available (defined in `nix/home/zsh/rc/dotfiles.nix`):

- `dotfiles switch` — apply configuration (`darwin-rebuild switch` on macOS, `home-manager switch` on Linux). Wraps `bin/scripts/switch.sh`.
- `dotfiles update` — run `nix flake update` against `nix/flake.lock`. Wraps `bin/scripts/update.sh`.
