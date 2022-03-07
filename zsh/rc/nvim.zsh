# NeoVim Home
export XDG_CONFIG_HOME="$HOME/.config"

# Replace vi with vim
if [ "$(uname)" '==' 'Darwin' ]; then
  if [[ "$(uname -m)" == "arm64" ]]; then
    alias vi='/opt/homebrew/bin/nvim'
  else
    alias vi='/usr/local/bin/nvim'
  fi
else
  alias vi='/usr/bin/nvim'
fi
