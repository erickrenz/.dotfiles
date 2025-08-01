vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.netrw_banner = 0

vim.o.number = true
vim.o.relativenumber = true

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.breakindent = true
vim.o.smartindent = true
vim.o.wrap = false

vim.o.swapfile = false
vim.o.undofile = true

vim.o.scrolloff = 8
vim.o.colorcolumn = '80'
vim.o.signcolumn = 'yes'
vim.o.inccommand = 'split'

vim.o.mouse = 'a'
vim.o.confirm = true
vim.o.showmode = false
vim.o.termguicolors = true
