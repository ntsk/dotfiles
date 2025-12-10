{ ... }:

# Zsh completion settings
{
  programs.zsh.completionInit = ''
    autoload -Uz compinit && compinit
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
    zstyle ':completion:*' menu select
    zstyle ':completion:*' list-colors '''
  '';
}
