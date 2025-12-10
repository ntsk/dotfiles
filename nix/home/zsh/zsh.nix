{ ... }:

{
  imports = [
    ./env/env.nix
    ./rc/directory.nix
    ./rc/completion.nix
    ./rc/history.nix
    ./rc/prompt.nix
    ./rc/buffer.nix
    ./rc/git.nix
    ./rc/docker.nix
    ./rc/k8s.nix
    ./rc/android.nix
    ./rc/mise.nix
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";
    historySubstringSearch.enable = true;
  };
}
