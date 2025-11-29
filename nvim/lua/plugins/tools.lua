return {
  {
    "thinca/vim-quickrun",
    cmd = "QuickRun",
    keys = {
      { "<Space>r", "<cmd>QuickRun -input =@+<cr>", desc = "QuickRun with clipboard" },
      { "<leader>r", "<cmd>QuickRun<cr>", desc = "QuickRun" },
    },
    dependencies = { "Shougo/vimproc.vim" },
    init = function()
      vim.g.quickrun_config = {
        _ = {
          ["outputter/error/success"] = "buffer",
          ["outputter/error/error"] = "quickfix",
          ["outputter/quickfix/open_cmd"] = "copen",
          runner = "vimproc",
          ["runner/vimproc/updatetime"] = 60,
          ["hook/time/enable"] = 1,
        },
        cpp = {
          command = "g++",
          input = "input",
          runner = "system",
        },
      }
    end,
  },
  {
    "Shougo/vimproc.vim",
    build = "make",
    lazy = true,
  },
}
