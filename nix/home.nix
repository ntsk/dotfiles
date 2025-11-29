{ config, pkgs, ... }:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    bat
    ctags
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
    zsh-history-substring-search
  ];
}
