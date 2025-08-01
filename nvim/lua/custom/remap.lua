vim.keymap.set('n', '-', vim.cmd.Ex)

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')

vim.keymap.set('n', '<leader>w', function()
  -- toggle word wrap
  if vim.wo.wrap then
    vim.wo.wrap = false
    vim.wo.linebreak = false
  else
    vim.wo.wrap = true
    vim.wo.linebreak = true
  end
end)
