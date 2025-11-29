return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.vcl = {
        install_info = {
          url = "https://github.com/ntsk/tree-sitter-vcl",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "vcl",
      }

      require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "vcl",
        command = "TSBufEnable highlight",
      })
    end,
  },
  {
    "fatih/vim-go",
    ft = "go",
    init = function()
      vim.g.go_fmt_command = "goimports"
      vim.g.go_metalinter_autosave = 1
      vim.g.go_def_mapping_enable = 0
      vim.g.go_doc_keywordprg_enable = 0
    end,
  },
  {
    "tpope/vim-rails",
    ft = "ruby",
  },
  {
    "previm/previm",
    ft = "markdown",
    init = function()
      vim.g.previm_open_cmd = "open -a Google\\ Chrome"
    end,
  },
  {
    "cespare/vim-toml",
    ft = "toml",
  },
  {
    "gruvw/strudel.nvim",
    build = "npm ci",
    ft = { "strudel" },
    keys = {
      { "<leader>sl", function() require("strudel").launch() end, desc = "Launch Strudel" },
      { "<leader>sq", function() require("strudel").quit() end, desc = "Quit Strudel" },
      { "<leader>st", function() require("strudel").toggle() end, desc = "Strudel Toggle Play/Stop" },
      { "<leader>su", function() require("strudel").update() end, desc = "Strudel Update" },
      { "<leader>ss", function() require("strudel").stop() end, desc = "Strudel Stop Playback" },
      { "<leader>sb", function() require("strudel").set_buffer() end, desc = "Strudel set current buffer" },
      { "<leader>sx", function() require("strudel").execute() end, desc = "Strudel set current buffer and update" },
    },
    config = function()
      require("strudel").setup({ update_on_save = true })

      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "*.str", "*.std" },
        callback = function()
          local strudel = require("strudel")
          if not strudel.is_launched() then
            strudel.launch()
          end
        end,
      })
    end,
  },
}
