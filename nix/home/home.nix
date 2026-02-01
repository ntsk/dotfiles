{ config, pkgs, lib, ... }:

{
  imports = [
    ./zsh/zsh.nix
    ./nvim/nvim.nix
  ];

  home.username = lib.mkDefault (builtins.getEnv "USER");
  home.homeDirectory = lib.mkDefault (
    if pkgs.stdenv.isDarwin
    then "/Users/${config.home.username}"
    else "/home/${config.home.username}"
  );
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    android-tools
    awscli2
    bundletool
    curl
    docker
    fd
    gh
    ghq
    google-cloud-sdk
    jq
    mise
    usage
    nerd-fonts.meslo-lg
    ripgrep
    terraform
    tig
    tmux
    wget
    wezterm
    zsh-completions
    zsh-fzf-tab
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    signing = {
      key = "9BE9091730B3EF4B";
      signByDefault = true;
    };
    settings = {
      user = {
        name = "ntsk";
        email = "ntsk@ntsk.jp";
      };
      init.defaultBranch = "main";
      core.editor = "nvim -c 'set fenc=utf-8'";
      gpg.program = "gpg";
      color.ui = "auto";
      ghq.root = "~/.ghq";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".claude" = {
    source = ../../claude;
    recursive = true;
  };

  xdg.configFile = {
    "wezterm" = {
      source = ../../wezterm;
      recursive = true;
    };
    "tig/config".source = ../../.tigrc;
    "tmux/tmux.conf".source = ../../.tmux.conf;
  };
}
