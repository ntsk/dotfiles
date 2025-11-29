vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

local opt = vim.opt

opt.number = true
opt.whichwrap:append("b,s,h,l,<,>,~,[,]")
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 5
opt.display:append("lastline")
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.clipboard:append({ "unnamed", "unnamedplus" })
opt.mouse = "a"
opt.showmode = false
opt.conceallevel = 0
opt.tags:append(vim.env.HOME .. "/tags")

local cache_dir = vim.fn.expand("$HOME/.cache/nvim")
local backup_dir = cache_dir .. "/backup"
local swap_dir = cache_dir .. "/swap"
local undo_dir = cache_dir .. "/undo"
local view_dir = cache_dir .. "/view"

local function ensure_dir(dir)
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
end

ensure_dir(cache_dir)
ensure_dir(backup_dir)
ensure_dir(swap_dir)
ensure_dir(undo_dir)
ensure_dir(view_dir)

opt.backup = true
opt.backupdir = backup_dir
opt.swapfile = true
opt.directory = swap_dir
opt.undofile = true
opt.undodir = undo_dir
opt.viewdir = view_dir

vim.cmd("syntax on")
