{ pkgs, lib, ... }:

# Basic neovim configuration managed by nix
# Plugins are managed by lazy.nvim (see nvim/lua/plugins/)
# LSP servers are managed by Mason
let
  # Tree-sitter parsers to install via Nix.
  # Neovim ships with these parsers built-in (do not list here):
  #   c, lua, markdown, markdown_inline, query, vim, vimdoc
  treesitterLanguages = [
    "python"
    "ruby"
    "go"
    "kotlin"
    "java"
    "swift"
    "rust"
  ];

  treesitterParsers = pkgs.runCommandLocal "nvim-treesitter-parsers" { } ''
    mkdir -p $out/parser $out/queries
    ${lib.concatMapStringsSep "\n" (lang: ''
      ln -s ${pkgs.tree-sitter-grammars."tree-sitter-${lang}"}/parser $out/parser/${lang}.so
      ln -s ${pkgs.tree-sitter-grammars."tree-sitter-${lang}"}/queries $out/queries/${lang}
    '') treesitterLanguages}
  '';
in
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
    plugins = [ treesitterParsers ];
  };
}
