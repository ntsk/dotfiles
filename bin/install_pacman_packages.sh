#!/bin/zsh

sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort $HOME/dotfiles/Pacfile))
