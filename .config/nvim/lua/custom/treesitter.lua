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

local nvim_treesitter = require 'nvim-treesitter'
nvim_treesitter.setup {
  install_dir = vim.fn.stdpath('data') .. '/site',
}
nvim_treesitter.install { 'rust' }

local function highlights_query(lang)
  local ok, query = pcall(vim.treesitter.query.get, lang, 'highlights')
  return ok and query ~= nil
end

local function notify_unavailable(lang, message)
  vim.notify_once(
    ('Tree-sitter %s: %s'):format(lang, message),
    vim.log.levels.WARN
  )
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('my-treesitter', { clear = true }),
  callback = function(ev)
    local lang = langs_by_filetype[vim.bo[ev.buf].filetype]
    if not lang then
      return
    end

    local ok, err = pcall(vim.treesitter.start, ev.buf, lang)
    if not ok then
      notify_unavailable(lang, err)
    elseif not highlights_query(lang) then
      notify_unavailable(lang, 'parser started, but no highlights query is available')
    end
  end,
})

vim.api.nvim_create_user_command('TreesitterStatus', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local lang = langs_by_filetype[vim.bo[bufnr].filetype]
  if not lang then
    vim.notify('Tree-sitter: no configured language for this buffer', vim.log.levels.WARN)
    return
  end

  local parser_ok, parser_err = pcall(vim.treesitter.get_parser, bufnr, lang)
  local query_ok = highlights_query(lang)
  local parser = parser_ok and 'available' or ('missing (' .. parser_err .. ')')
  local highlights = query_ok and 'available' or 'missing'
  vim.notify(('Tree-sitter %s — parser: %s; highlights query: %s'):format(lang, parser, highlights))
end, { desc = 'Show Tree-sitter parser and highlight-query status' })
