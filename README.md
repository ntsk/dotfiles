# dotfiles
![](https://github.com/ntsk/dotfiles/workflows/CI/badge.svg)

## Install
```
$ curl -sL https://raw.githubusercontent.com/ntsk/dotfiles/master/bin/install.sh | sh
```

## Setup
### 1. Install packages
Setup package manager and Install packages from a list.

#### Homebrew
```
$ dotfiles/bin/install_homebrew.sh
```

#### Pacman
```
$ dotfiles/bin/install_pacman_packages.sh
```

### 2. Install Prezto
Install [Prezto](https://github.com/sorin-ionescu/prezto) and [prezto-prompt-simple](https://github.com/kami-zh/prezto-prompt-simple) theme.
```
$ dotfiles/bin/install_prezto.sh
```

### 3 .Generate symlink
Generate symbolic links to required directories.
```
$ dotfiles/bin/dotfiles.symlink.sh
$ dotfiles/bin/zsh.symlink.sh
```

## Color Schemes and Fonts
- [iTerm2-Color-Schemes](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/schemes/Molokai.itermcolors)
- [powerline/fonts](https://github.com/powerline/fonts)
- [supermaring/powerline-fonts](https://github.com/supermarin/powerline-fonts)
