 #!/bin/zsh

VIM_FILES=(.vim .vimrc)
echo "[Setup vim]"
for file in ${VIM_FILES[@]}
  do
      ln -s $HOME/dotfiles/$file $HOME/$file
  done

ZSH_FILES=(zlogin zlogout zpreztorc zprofile zshenv zshrc)
echo "[Setup zsh + prezto]"
if [ -e "$HOME/.zprezto/runcoms" ]; then
  for file in ${ZSH_FILES[@]}
    do
      rm -f $HOME/.zprezto/runcoms/$file
      ln -s $HOME/dotfiles/$file $HOME/.zprezto/runcoms/$file
      ln -s $HOME/.zprezto/runcoms/$file $HOME/.$file
    done
else
  echo "Please install prezto before setup !"
fi

