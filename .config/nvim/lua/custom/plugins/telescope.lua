require('telescope').setup {
  defaults = {
    layout_strategy = 'flex',
    layout_config = {
      flex = {
        flip_columns = 120,
      },
    },
  },
  extensions = {
    fzf = {},
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
}

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>gf', builtin.git_files)
vim.keymap.set('n', '<leader>sf', builtin.find_files)

vim.keymap.set('n', '<leader>sd', builtin.diagnostics)
vim.keymap.set('n', '<leader>sh', builtin.help_tags)

vim.keymap.set('n', '<leader>sw', builtin.grep_string)
vim.keymap.set('n', '<leader>sg', builtin.live_grep)

vim.keymap.set('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end)
