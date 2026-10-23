require('mason').setup()
require('mason-tool-installer').setup {
  ensure_installed = {
    'clangd',
    'cpptools',
    'delve',
    'gopls',
    'lua-language-server',
    'pyright',
    'rust-analyzer',
    'typescript-language-server',
    'zls',
    'stylua',
  },
}

require('fidget').setup {}

require('lazydev').setup {
  library = {
    -- Load luvit types when the `vim.uv` word is found
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}
