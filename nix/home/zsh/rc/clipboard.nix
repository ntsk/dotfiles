{ pkgs, ... }:

{
  programs.zsh.initContent = ''
    if [[ "$(uname)" == "Linux" ]]; then
      alias pbcopy='xclip -selection clipboard'
      alias pbpaste='xclip -selection clipboard -o'
    fi
  '';
}
