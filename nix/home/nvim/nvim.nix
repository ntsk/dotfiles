{ ... }:

# Basic neovim configuration managed by nix
# Plugins are managed by lazy.nvim (see nvim/lua/plugins/)
# LSP servers are managed by Mason
{
  imports = [
    ./config/options.nix
    ./config/keymaps.nix
    ./config/autocmds.nix
    ./config/lazy.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
