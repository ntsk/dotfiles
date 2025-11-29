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

  home.packages = with pkgs; [
    curl
    ghq
    jq
    mise
    neovim
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
