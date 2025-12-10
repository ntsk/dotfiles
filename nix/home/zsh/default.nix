{ config, pkgs, lib, ... }:

{
  imports = [
    ./env.nix
    ./directory.nix
    ./completion.nix
    ./history.nix
    ./prompt.nix
    ./buffer.nix
    ./nvim.nix
    ./git.nix
    ./docker.nix
    ./k8s.nix
    ./android.nix
    ./mise.nix
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";
    historySubstringSearch.enable = true;
  };
}
