#!/bin/zsh

ln -sf $HOME/dotfiles/.gitconfig $HOME/.gitconfig
ln -sf $HOME/dotfiles/.tigrc $HOME/.tigrc
ln -sf $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
ln -sf $HOME/dotfiles/.ctags $HOME/.ctags
ln -sf $HOME/dotfiles/peco $HOME/.peco
mkdir -p $HOME/.config
ln -sf $HOME/dotfiles/nvim $HOME/.config/nvim
ln -sf $HOME/dotfiles/wezterm $HOME/.config/wezterm

if [ -d $HOME/.claude ]; then
  ln -sf $HOME/dotfiles/.claude/CLAUDE.md $HOME/.claude/CLAUDE.md
  ln -sf $HOME/dotfiles/.claude/settings.json $HOME/.claude/settings.json
else
  ln -sf $HOME/dotfiles/.claude $HOME/.claude
fi
