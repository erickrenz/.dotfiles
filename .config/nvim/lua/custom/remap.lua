vim.keymap.set('n', '-', vim.cmd.Ex)

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics to location list' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Line diagnostic' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')

local function jump_next_or_close_paren()
  if vim.snippet.active { direction = 1 } then
    vim.snippet.jump { direction = 1 }
    return
  end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]

  if line and line:sub(col + 1, col + 1) == ')' then
    vim.api.nvim_win_set_cursor(0, { row, col + 1 })
  end
end

vim.keymap.set({ 'i', 's' }, '<C-l>', jump_next_or_close_paren, {
  desc = 'Jump to next snippet argument or past closing parenthesis',
})

vim.keymap.set({ 'i', 's' }, '<C-h>', function()
  if vim.snippet.active { direction = -1 } then
    vim.snippet.jump { direction = -1 }
  end
end, { desc = 'Jump to previous snippet argument' })

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
