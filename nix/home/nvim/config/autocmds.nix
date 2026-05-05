{ ... }:

# Auto commands for file types and events
{
  programs.neovim.initLua = ''
    local augroup = vim.api.nvim_create_augroup
    local autocmd = vim.api.nvim_create_autocmd

    local mygroup = augroup("MyAutoCmd", { clear = true })

    vim.filetype.add({
      extension = {
        vcl = "vcl",
        str = "strudel",
        std = "strudel",
      },
    })

    vim.treesitter.language.register("c_sharp", "cs")

    -- Stub locals-scope predicates from nvim-treesitter that some grammar
    -- queries reference. Without proper locals.scm analysis we cannot evaluate
    -- them; return safe defaults so highlighting does not error out.
    vim.treesitter.query.add_predicate("is?", function() return false end, { force = true, all = false })
    vim.treesitter.query.add_predicate("is-not?", function() return true end, { force = true, all = false })
    vim.treesitter.query.add_predicate("has-ancestor?", function() return false end, { force = true, all = false })
    vim.treesitter.query.add_predicate("has-parent?", function() return false end, { force = true, all = false })

    autocmd("FileType", {
      group = mygroup,
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })

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
