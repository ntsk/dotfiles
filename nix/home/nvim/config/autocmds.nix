{ ... }:

# Auto commands for file types and events
{
  programs.neovim.extraLuaConfig = ''
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
  '';
}
