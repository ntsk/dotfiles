{ pkgs, ... }:

# Zsh completion settings
{
  programs.zsh.completionInit = ''
    autoload -Uz compinit && compinit
    source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
    zstyle ':completion:*' list-colors '''
  '';
}
