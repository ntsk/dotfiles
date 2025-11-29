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
    "cohama/lexima.vim",
    event = "InsertEnter",
  },
  {
    "tpope/vim-surround",
    event = { "BufReadPost", "BufNewFile" },
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
