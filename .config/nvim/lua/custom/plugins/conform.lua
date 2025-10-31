return {
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = function()
      return {
        timeout_ms = 500,
        lsp_format = 'fallback',
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'gofmt' },
      python = { 'isort', 'black' },
      javascript = { { 'prettierd', 'prettier' } },
      typescript = { { 'prettierd', 'prettier' } },
      rust = { 'rustfmt' },
    },
  },
}
