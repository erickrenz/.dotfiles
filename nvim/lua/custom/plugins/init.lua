return {
  -- detect tabstop and shift width automatically
  'NMAC427/guess-indent.nvim',

  -- git decorations for changed lines
  { 'lewis6991/gitsigns.nvim', opts = {} },

  -- highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
}
