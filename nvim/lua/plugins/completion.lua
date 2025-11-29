return {
  {
    "vim-denops/denops.vim",
    lazy = false,
  },
  {
    "Shougo/ddc.vim",
    event = "InsertEnter",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/ddc-around",
      "Shougo/ddc-source-lsp",
      "Shougo/ddc-matcher_head",
      "Shougo/ddc-sorter_rank",
      "Shougo/ddc-ui-native",
    },
    config = function()
      vim.fn["ddc#custom#patch_global"]("ui", "native")
      vim.fn["ddc#custom#patch_global"]("sources", { "lsp", "around" })
      vim.fn["ddc#custom#patch_global"]("sourceOptions", {
        _ = {
          matchers = { "matcher_head" },
          sorters = { "sorter_rank" },
        },
        around = {
          mark = "around",
        },
        lsp = {
          mark = "lsp",
          forceCompletionPattern = [[\.\w*|:\w*|->\w*]],
        },
      })
      vim.fn["ddc#enable"]()
    end,
  },
  { "Shougo/ddc-around", lazy = true },
  { "Shougo/ddc-source-lsp", lazy = true },
  { "Shougo/ddc-matcher_head", lazy = true },
  { "Shougo/ddc-sorter_rank", lazy = true },
  { "Shougo/ddc-ui-native", lazy = true },
}
