{ config, ... }:

# lazy.nvim plugin manager setup
# Plugins are defined in nvim/lua/plugins/
{
  programs.neovim.initLua = ''
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
      })
    end
    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup("plugins", {
      defaults = { lazy = true },
      install = { colorscheme = { "tokyonight" } },
      checker = { enabled = false },
      performance = {
        rtp = {
          disabled_plugins = {
            "gzip",
            "matchit",
            "matchparen",
            "netrwPlugin",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
          },
        },
      },
    })
  '';

  xdg.configFile = {
    "nvim/lua/plugins" = {
      source = ../../../../nvim/lua/plugins;
      recursive = true;
    };
    "nvim/lazy-lock.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim/lazy-lock.json";
  };
}
