return {
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
}
