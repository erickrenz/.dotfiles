local cmp = require 'cmp'

cmp.setup {
  -- snippets expand via vim.snippet; <C-l>/<C-h> jumps live in remap.lua
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  completion = { completeopt = 'menu,menuone,noinsert' },

  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),

    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    ['<C-y>'] = cmp.mapping.confirm { select = true },
    ['<C-Space>'] = cmp.mapping.complete(),

    ['<CR>'] = nil,
    ['<Tab>'] = nil,
    ['<S-Tab>'] = nil,
  },
  sources = {
    {
      name = 'lazydev',
      -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
      group_index = 0,
    },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
  },
}

vim.lsp.config('*', { capabilities = require('cmp_nvim_lsp').default_capabilities() })
