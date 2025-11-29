return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      {
        "<C-p>",
        function()
          require("telescope.builtin").find_files({
            prompt_title = "Search Everywhere",
            find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
          })
        end,
        desc = "Find Files",
      },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-n>"] = "move_selection_next",
            ["<C-p>"] = "move_selection_previous",
          },
        },
      },
    },
  },
}
