# NeoVim Home
export XDG_CONFIG_HOME="$HOME/.config"

# Replace vi with vim
if [ "$(uname)" '==' 'Darwin' ]; then
  alias vi='/usr/local/bin/nvim'
else
  alias vi='/usr/bin/nvim'
fi
