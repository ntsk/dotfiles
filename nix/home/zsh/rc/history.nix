{ config, ... }:

# History settings and search function
{
  programs.zsh = {
    history = {
      path = "${config.home.homeDirectory}/.zsh_history";
      size = 1000;
      save = 100000;
      ignoreDups = true;
      extended = true;
    };

    initContent = ''
      # Search history
      function select-history() {
        local tac
        if which tac > /dev/null; then
          tac="tac"
        else
          tac="tail -r"
        fi
        BUFFER=$(fc -l -n 1 | eval $tac | fzf --exact --no-sort --query "^$LBUFFER")
        CURSOR=$#BUFFER
        zle -R -c
      }
      zle -N select-history
      bindkey '^r' select-history
    '';
  };
}
