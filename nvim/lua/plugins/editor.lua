return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
      { "<C-e>", "<cmd>Oil<cr>", desc = "Open Oil" },
    },
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "tzachar/highlight-undo.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
  {
    "alvan/vim-closetag",
    ft = { "html", "xhtml", "phtml", "xml", "vue" },
    init = function()
      vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml,*.vue"
      vim.g.closetag_filetypes = "html,xhtml,phtml,xml,vue"
    end,
  },
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "vue", "jsx", "tsx" },
  },
  {
    "mechatroner/rainbow_csv",
    ft = { "csv", "tsv" },
  },
}
