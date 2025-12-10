{ ... }:

# Mise (runtime version manager) activation
{
  programs.zsh.initContent = ''
    eval "$(mise activate zsh)"
  '';
}
