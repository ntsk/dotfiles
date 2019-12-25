if [ "$(uname)" '==' 'Darwin' ]; then
  alias ctags="`brew --prefix`/bin/ctags"
fi

function gtags() {
  local dir=`pwd`
  ctags -R -f ~/tags $dir
}
