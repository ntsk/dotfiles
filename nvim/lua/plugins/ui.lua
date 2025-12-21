return {
  {
    "MaximilianLloyd/ascii.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    lazy = true,
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons", "MaximilianLloyd/ascii.nvim" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      local ascii = require("ascii")

      dashboard.section.header.val = ascii.art.text.neovim.sharp

      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
        dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", "  Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      alpha.setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local version = vim.version()
          local lazy_stats = require("lazy").stats()
          dashboard.section.footer.val = string.format(
            "Neovim v%d.%d.%d   %d plugins   %.2fms",
            version.major,
            version.minor,
            version.patch,
            lazy_stats.count,
            lazy_stats.startuptime
          )
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
  {
    "itchyny/lightline.vim",
    lazy = false,
    init = function()
      vim.g.lightline = { colorscheme = "wombat" }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  {
    "ntpeters/vim-better-whitespace",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
  },
}
