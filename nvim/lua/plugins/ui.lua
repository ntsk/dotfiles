return {
  {
    "itchyny/lightline.vim",
    lazy = false,
    init = function()
      vim.g.lightline = { colorscheme = "wombat" }
    end,
  },
  {
    "Yggdroot/indentLine",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "ntpeters/vim-better-whitespace",
    event = { "BufReadPost", "BufNewFile" },
  },
}
