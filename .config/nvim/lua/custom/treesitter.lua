local langs_by_filetype = {
  c = 'c',
  cpp = 'cpp',
  go = 'go',
  javascript = 'javascript',
  javascriptreact = 'javascript',
  lua = 'lua',
  markdown = 'markdown',
  python = 'python',
  rust = 'rust',
  typescript = 'typescript',
  typescriptreact = 'tsx',
  vim = 'vim',
  vimdoc = 'vimdoc',
  zig = 'zig',
}

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('my-treesitter', { clear = true }),
  callback = function(ev)
    local lang = langs_by_filetype[vim.bo[ev.buf].filetype]
    if lang then
      pcall(vim.treesitter.start, ev.buf, lang)
    end
  end,
})
