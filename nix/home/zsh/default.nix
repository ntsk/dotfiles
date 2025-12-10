{ config, pkgs, lib, ... }:

{
  imports = [
    ./git.nix
    ./docker.nix
    ./k8s.nix
    ./android.nix
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    defaultKeymap = "viins";

    history = {
      path = "${config.home.homeDirectory}/.zsh_history";
      size = 1000;
      save = 100000;
      ignoreDups = true;
      extended = true;
    };

    historySubstringSearch.enable = true;

    completionInit = ''
      autoload -Uz compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
      zstyle ':completion:*' menu select
      zstyle ':completion:*' list-colors '''
    '';

    shellAliases = {
      vi = "nvim";
      repos = "cd $(ghq root)/$(ghq list | fzf)";
    };

    sessionVariables = {
      XDG_CONFIG_HOME = "$HOME/.config";
      GOPATH = "$HOME/go";
      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "less";
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      GPG_TTY = "$(tty)";
    };

    envExtra = ''
      typeset -gU cdpath fpath mailpath path

      path=(
        $HOME/.nix-profile/bin
        /usr/local/{bin,sbin}
        $GOPATH/bin
        $HOME/.local/share/mise/shims
        $path
      )

      if [[ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]]; then
        source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi

      if [[ "$(uname -m)" == "arm64" ]] && [[ -f /opt/homebrew/bin/brew ]]; then
        eval $(/opt/homebrew/bin/brew shellenv)
      fi

      if [[ "$OSTYPE" == darwin* ]]; then
        export BROWSER='open'
      fi
    '';

    initContent = ''
      setopt AUTO_CD
      setopt AUTO_PUSHD
      setopt PUSHD_IGNORE_DUPS
      setopt PUSHD_SILENT
      setopt PUSHD_TO_HOME
      setopt CDABLE_VARS
      setopt MULTIOS
      setopt EXTENDED_GLOB
      unsetopt CLOBBER

      setopt PROMPT_SUBST
      autoload -Uz colors && colors
      autoload -Uz add-zsh-hook
      autoload -Uz vcs_info

      zstyle ':vcs_info:*' enable git
      zstyle ':vcs_info:git:*' check-for-changes true
      zstyle ':vcs_info:git:*' stagedstr '+'
      zstyle ':vcs_info:git:*' unstagedstr '+'
      zstyle ':vcs_info:git:*' formats '%c%u %F{8}%b%f'
      zstyle ':vcs_info:git:*' actionformats '%c%u %F{8}%b%f|%F{1}%a%f'

      _update_vcs_info() {
        vcs_info
        if [[ -n ''${vcs_info_msg_0_} ]]; then
          if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
            vcs_info_msg_0_="%F{3}+ ''${vcs_info_msg_0_#* }%f"
          else
            vcs_info_msg_0_=" ''${vcs_info_msg_0_}"
          fi
        fi
      }
      add-zsh-hook precmd _update_vcs_info

      PROMPT='%F{2}%c%f %F{6}❯%f '
      RPROMPT='${"$"}{vcs_info_msg_0_}'

      function find_buffer() {
        local current_buffer=$BUFFER
        local search_root=""
        local file_path=""

        if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
          search_root=$(git rev-parse --show-toplevel)
        else
          search_root=$(pwd)
        fi
        file_path="$(find ''${search_root} -maxdepth 5 | fzf)"
        BUFFER="''${current_buffer} ''${file_path}"
        CURSOR=$#BUFFER
        zle clear-screen
      }
      zle -N find_buffer
      bindkey '^f' find_buffer

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

      eval "$(mise activate zsh)"
    '';
  };
}
