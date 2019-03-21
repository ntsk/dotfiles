# Setup
```
git clone https://github.com/NTSK/dotfiles.git
chmod -R +x dotfiles/bin
```

## Install Homebrew
```
dotfiles/bin/install_homebrew.sh
```

## Install Prezto
```
dotfiles/bin/install_prezto.sh
```

## Generate symlink
Generate symbolic links to required directories.
```
dotfiles/bin/dotfiles.symlink.sh
dotfiles/bin/zsh.symlink.sh
dotfiles/bin/nvim.symlink.sh
```

# Other
- [iTerm2-Color-Schemes](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/schemes/Molokai.itermcolors)
- [powerline/fonts](https://github.com/powerline/fonts)
- [supermaring/powerline-fonts](https://github.com/supermarin/powerline-fonts)

# Uninstall Prezto
If you want to uninstall prezto, please remove dotfiles.
```
rm -rf ~/.zprezto ~/.zlogin ~/.zlogout ~/.zpreztorc ~/.zprofile ~/.zshenv ~/.zshrc
```
