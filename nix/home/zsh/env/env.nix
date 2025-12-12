{ config, ... }:

{
  programs.zsh = {
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
        /nix/var/nix/profiles/default/bin
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
  };
}
