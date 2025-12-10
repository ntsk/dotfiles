{ ... }:

# Basic neovim configuration managed by nix
# Plugins are managed by lazy.nvim (see nvim/lua/plugins/)
# LSP servers are managed by Mason
{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./autocmds.nix
    ./lazy.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
