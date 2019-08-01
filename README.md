# Setup
```
git clone https://github.com/NTSK/dotfiles.git
chmod -R +x dotfiles/bin
```

## Install Homebrew & Restore dependencies from Brewfile
```
dotfiles/bin/install_homebrew.sh
```

## Install & Uninstall Prezto
Please install Prezto before generating symlink.
```
dotfiles/bin/install_prezto.sh
dotfiles/bin/uninstall_prezto.sh
```

## Generate symlink
Generate symbolic links to required directories.
```
dotfiles/bin/dotfiles.symlink.sh
dotfiles/bin/zsh.symlink.sh
```

# Other
- [iTerm2-Color-Schemes](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/schemes/Molokai.itermcolors)
- [powerline/fonts](https://github.com/powerline/fonts)
- [supermaring/powerline-fonts](https://github.com/supermarin/powerline-fonts)
