{ config, pkgs, lib, ... }:

{
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
    awscli2
    curl
    docker
    fzf
    gh
    ghq
    git-lfs
    google-cloud-sdk
    jq
    mise
    neovim
    nerd-fonts.meslo-lg
    peco
    ripgrep
    tig
    tmux
    vim
    wget
    wezterm
    zsh
  ];
}
