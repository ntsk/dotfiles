{ pkgs, ... }:

# Zsh completion settings
{
  programs.zsh.completionInit = ''
    autoload -Uz compinit && compinit
    autoload -Uz bashcompinit && bashcompinit
    complete -C '${pkgs.awscli2}/bin/aws_completer' aws
    eval "$(${pkgs.gh}/bin/gh completion -s zsh)"
    eval "$(${pkgs.mise}/bin/mise completion zsh)"
    eval "$(${pkgs.ripgrep}/bin/rg --generate complete-zsh)"
    eval "$(${pkgs.fd}/bin/fd --gen-completions zsh)"
    source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
    zstyle ':completion:*' list-colors '''
  '';
}
