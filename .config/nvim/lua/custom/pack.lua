vim.pack.add({
  'https://github.com/folke/tokyonight.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/lewis6991/gitsigns.nvim',
}, { load = true, confirm = false })

require('tokyonight').setup {
  style = 'night',
  on_colors = function() end,
  on_highlights = function() end,
}
vim.cmd.colorscheme 'tokyonight'

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = '|',
    section_separators = '',
  },
}

require('gitsigns').setup()

require('telescope').setup {
  defaults = {
    layout_strategy = 'flex',
    layout_config = {
      flex = {
        flip_columns = 120,
      },
    },
  },
}

local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Telescope git files' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope files' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Telescope diagnostics' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope help' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Telescope word' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope grep' })
vim.keymap.set('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = 'Telescope buffer' })

vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Fugitive status' })

vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('my_fugitive', {}),
  pattern = '*',
  callback = function()
    if vim.bo.ft ~= 'fugitive' then
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set('n', '<leader>p', function()
      vim.cmd.Git 'push'
    end, opts)

    vim.keymap.set('n', '<leader>P', function()
      vim.cmd.Git 'pull --rebase'
    end, opts)
  end,
})
