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
  #               lang = treesitter language name (parser/queries dir name),
  #               queryDir = path to the queries directory within the grammar
  #                          (optional, defaults to "queries") }
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
    { pkg = "html"; lang = "html"; }
    { pkg = "css"; lang = "css"; }
    { pkg = "vcl"; lang = "vcl"; }
    { pkg = "nix"; lang = "nix"; }
    { pkg = "yaml"; lang = "yaml"; }
    { pkg = "bash"; lang = "bash"; }
    { pkg = "json"; lang = "json"; }
    # tree-sitter-xml ships queries for both xml and dtd; pick the xml one.
    { pkg = "xml"; lang = "xml"; queryDir = "queries/xml"; }
    { pkg = "toml"; lang = "toml"; }
  ];

  treesitterParsers = pkgs.runCommandLocal "nvim-treesitter-parsers" { } ''
    mkdir -p $out/parser $out/queries
    ${lib.concatMapStringsSep "\n" (e:
      let
        grammar = pkgs.tree-sitter-grammars."tree-sitter-${e.pkg}";
        queryDir = e.queryDir or "queries";
      in ''
        ln -s ${grammar}/parser $out/parser/${e.lang}.so
        if [ -d ${grammar}/${queryDir} ]; then
          ln -s ${grammar}/${queryDir} $out/queries/${e.lang}
        elif [ -d ${grammar.src}/${queryDir} ]; then
          ln -s ${grammar.src}/${queryDir} $out/queries/${e.lang}
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
    # Disable language providers we don't use. Ruby provider in particular
    # leaks GEM_HOME into child processes (e.g. mason's ruby-lsp), causing it
    # to try to install bundler into the read-only /nix/store.
    withRuby = false;
    withPython3 = false;
    withNodeJs = false;
    # Prepend after lazy.setup to survive lazy.nvim's rtp reset.
    initLua = lib.mkAfter ''
      vim.opt.rtp:prepend("${treesitterParsers}")
    '';
  };
}
