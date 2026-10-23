-- Build steps that lazy.nvim used to run via `build`. Must be registered
-- before any vim.pack.add() so they fire on first install.
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('my-vim-pack', { clear = true }),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind == 'delete' then
      return
    end

    if name == 'telescope-fzf-native.nvim' then
      local result = vim.system({ 'make' }, { cwd = ev.data.path }):wait()
      if result.code ~= 0 then
        vim.notify('telescope-fzf-native: make failed\n' .. result.stderr, vim.log.levels.ERROR)
      end
    elseif name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    end
  end,
})

local gh = function(repo)
  return 'https://github.com/' .. repo
end

vim.pack.add {
  gh 'folke/tokyonight.nvim',
  gh 'nvim-lua/plenary.nvim',
  gh 'nvim-tree/nvim-web-devicons',

  -- plugins/init.lua
  gh 'NMAC427/guess-indent.nvim',
  gh 'lukas-reineke/indent-blankline.nvim',
  gh 'lewis6991/gitsigns.nvim',
  gh 'folke/todo-comments.nvim',

  -- nvim-lspconfig only supplies lsp/<server>.lua defaults for vim.lsp.config
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  gh 'j-hui/fidget.nvim',
  gh 'folke/lazydev.nvim',

  gh 'hrsh7th/nvim-cmp',
  gh 'hrsh7th/cmp-nvim-lsp',
  gh 'hrsh7th/cmp-path',
  gh 'hrsh7th/cmp-buffer',

  gh 'stevearc/conform.nvim',
  gh 'tpope/vim-fugitive',
  { src = gh 'ThePrimeagen/harpoon', version = 'harpoon2' },
  gh 'nvim-lualine/lualine.nvim',

  { src = gh 'nvim-telescope/telescope.nvim', version = vim.version.range '0.2' },
  gh 'nvim-telescope/telescope-ui-select.nvim',
  gh 'nvim-telescope/telescope-fzf-native.nvim',

  gh 'nvim-treesitter/nvim-treesitter',
  gh 'folke/trouble.nvim',
  gh 'mbbill/undotree',
}

vim.api.nvim_create_user_command('PackUpdate', function(opts)
  vim.pack.update(nil, { force = opts.bang })
end, {
  bang = true,
  desc = 'Check plugin updates (! applies all updates)',
})

require 'custom.plugins.colors'
require 'custom.plugins'
require 'custom.plugins.lsp'
require 'custom.plugins.cmp'
require 'custom.plugins.conform'
require 'custom.plugins.fugitive'
require 'custom.plugins.harpoon'
require 'custom.plugins.lualine'
require 'custom.plugins.telescope'
require 'custom.plugins.treesitter'
require 'custom.plugins.trouble'
require 'custom.plugins.undotree'
