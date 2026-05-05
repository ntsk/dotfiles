{ pkgs, lib, ... }:

# Basic neovim configuration managed by nix
# Plugins are managed by lazy.nvim (see nvim/lua/plugins/)
# LSP servers are managed by Mason
let
  # Tree-sitter parsers to install via Nix.
  # Neovim ships with these parsers built-in (do not list here):
  #   c, lua, markdown, markdown_inline, query, vim, vimdoc
  #
  # Each entry: { pkg = nixpkgs grammar attribute name (without "tree-sitter-" prefix),
  #               lang = treesitter language name (parser/queries dir name) }
  treesitterLanguages = [
    { pkg = "python"; lang = "python"; }
    { pkg = "ruby"; lang = "ruby"; }
    { pkg = "go"; lang = "go"; }
    { pkg = "kotlin"; lang = "kotlin"; }
    { pkg = "java"; lang = "java"; }
    { pkg = "swift"; lang = "swift"; }
    { pkg = "rust"; lang = "rust"; }
    { pkg = "javascript"; lang = "javascript"; }
    { pkg = "typescript"; lang = "typescript"; }
    { pkg = "cpp"; lang = "cpp"; }
    { pkg = "c-sharp"; lang = "c_sharp"; }
  ];

  treesitterParsers = pkgs.runCommandLocal "nvim-treesitter-parsers" { } ''
    mkdir -p $out/parser $out/queries
    ${lib.concatMapStringsSep "\n" (e:
      let
        grammar = pkgs.tree-sitter-grammars."tree-sitter-${e.pkg}";
      in ''
        ln -s ${grammar}/parser $out/parser/${e.lang}.so
        if [ -d ${grammar}/queries ]; then
          ln -s ${grammar}/queries $out/queries/${e.lang}
        elif [ -d ${grammar.src}/queries ]; then
          ln -s ${grammar.src}/queries $out/queries/${e.lang}
        fi
      ''
    ) treesitterLanguages}
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
    # Prepend after lazy.setup to survive lazy.nvim's rtp reset.
    initLua = lib.mkAfter ''
      vim.opt.rtp:prepend("${treesitterParsers}")
    '';
  };
}
