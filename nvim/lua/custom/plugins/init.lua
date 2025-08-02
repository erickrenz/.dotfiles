return {
  { 'NMAC427/guess-indent.nvim', opts = {} },

  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },

  { 'lewis6991/gitsigns.nvim', opts = {} },

  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
}
