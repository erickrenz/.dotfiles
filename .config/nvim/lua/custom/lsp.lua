vim.diagnostic.config {
  virtual_text = true,
  float = {
    focusable = false,
    source = true,
    style = 'minimal',
    border = 'rounded',
    header = '', -- "Diagnostics:"
    prefix = '', -- "1. "
  },
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my-lsp-attach', { clear = true }),
  callback = function(event)
    local opts = { buffer = event.buf }
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id), 'must have valid client')

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)

    -- return from definition using CTRL-O (see :h CTRL-O)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)

    vim.keymap.set('n', '[d', function()
      vim.diagnostic.jump { count = -1, float = true }
    end, opts)
    vim.keymap.set('n', ']d', function()
      vim.diagnostic.jump { count = 1, float = true }
    end, opts)

    if client:supports_method('textDocument/inlayHint', event.buf) then
      vim.keymap.set('n', '<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }, { bufnr = event.buf })
      end, opts)
    end

    if client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('my-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('my-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'my-lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})

-- Server defaults (cmd, filetypes, root markers) come from nvim-lspconfig's
-- lsp/<name>.lua; these tables only hold overrides.
local servers = {
  clangd = {},
  gopls = {
    settings = {
      -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
      gopls = {
        -- completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          -- fieldalignment = true,
          shadow = true,
          unusedvariable = true,
          useany = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  -- ltex = {},
  lua_ls = {},
  pyright = {},
  rust_analyzer = {},
  ts_ls = {},
  zls = {
    settings = {
      zls = {
        enable_inlay_hints = true,
        enable_snippets = true,
        warn_style = true,
      },
    },
  },
}

for name, config in pairs(servers) do
  vim.lsp.config(name, config)
end
vim.lsp.enable(vim.tbl_keys(servers))
