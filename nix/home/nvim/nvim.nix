{ config, pkgs, lib, ... }:

# Basic neovim configuration managed by nix
# Plugins are managed by lazy.nvim (see nvim/lua/plugins/)
# LSP servers are managed by Mason
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraLuaConfig = ''
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      vim.scriptencoding = "utf-8"
      vim.opt.encoding = "utf-8"
      vim.opt.fileencoding = "utf-8"

      local opt = vim.opt

      opt.number = true
      opt.whichwrap:append("b,s,h,l,<,>,~,[,]")
      opt.incsearch = true
      opt.ignorecase = true
      opt.smartcase = true
      opt.scrolloff = 5
      opt.display:append("lastline")
      opt.tabstop = 2
      opt.softtabstop = 2
      opt.shiftwidth = 2
      opt.expandtab = true
      opt.autoindent = true
      opt.smartindent = true
      opt.clipboard:append({ "unnamed", "unnamedplus" })
      opt.mouse = "a"
      opt.showmode = false
      opt.conceallevel = 0
      opt.tags:append(vim.env.HOME .. "/tags")

      local cache_dir = vim.fn.expand("$HOME/.cache/nvim")
      local backup_dir = cache_dir .. "/backup"
      local swap_dir = cache_dir .. "/swap"
      local undo_dir = cache_dir .. "/undo"
      local view_dir = cache_dir .. "/view"

      local function ensure_dir(dir)
        if vim.fn.isdirectory(dir) == 0 then
          vim.fn.mkdir(dir, "p")
        end
      end

      ensure_dir(cache_dir)
      ensure_dir(backup_dir)
      ensure_dir(swap_dir)
      ensure_dir(undo_dir)
      ensure_dir(view_dir)

      opt.backup = true
      opt.backupdir = backup_dir
      opt.swapfile = true
      opt.directory = swap_dir
      opt.undofile = true
      opt.undodir = undo_dir
      opt.viewdir = view_dir

      vim.cmd("syntax on")

      -- Keymaps
      local keymap = vim.keymap.set

      keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

      keymap("i", "<Tab>", function()
        return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
      end, { expr = true })

      keymap("i", "<S-Tab>", function()
        return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
      end, { expr = true })

      -- Autocmds
      local augroup = vim.api.nvim_create_augroup
      local autocmd = vim.api.nvim_create_autocmd

      local mygroup = augroup("MyAutoCmd", { clear = true })

      autocmd("FileType", {
        group = mygroup,
        pattern = "vue",
        command = "syntax sync fromstart",
      })

      autocmd({ "BufNewFile", "BufRead" }, {
        group = mygroup,
        pattern = "*.dig",
        command = "set filetype=yaml",
      })

      autocmd({ "BufNewFile", "BufRead" }, {
        group = mygroup,
        pattern = "*.vue",
        command = "setlocal filetype=vue",
      })

      autocmd({ "BufNewFile", "BufRead" }, {
        group = mygroup,
        pattern = "*.tsx",
        command = "set filetype=typescript.tsx",
      })

      autocmd({ "BufNewFile", "BufRead" }, {
        group = mygroup,
        pattern = { "Dangerfile", "Fastfile" },
        command = "set filetype=ruby",
      })

      autocmd({ "BufNewFile", "BufRead" }, {
        group = mygroup,
        pattern = { "*.hql", "*.q" },
        command = "set filetype=hive",
      })

      autocmd({ "BufNewFile", "BufRead" }, {
        group = mygroup,
        pattern = { "*.vcl", "*.vcl.j2" },
        command = "set filetype=vcl",
      })

      autocmd("BufRead", {
        group = mygroup,
        callback = function()
          local mark = vim.api.nvim_buf_get_mark(0, '"')
          local lcount = vim.api.nvim_buf_line_count(0)
          if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
          end
        end,
      })

      -- lazy.nvim setup
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
        install = { colorscheme = { "molokai" } },
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
  };

  xdg.configFile = {
    "nvim/lua/plugins" = {
      source = ../../../nvim/lua/plugins;
      recursive = true;
    };
    "nvim/lazy-lock.json".source = ../../../nvim/lazy-lock.json;
  };
}
