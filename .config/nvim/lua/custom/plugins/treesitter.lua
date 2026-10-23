-- nvim-treesitter's `main` branch only installs parsers and queries;
-- highlighting is Neovim's builtin, started per buffer below.
local ts = require 'nvim-treesitter'

ts.install {
  'c',
  'cpp',
  'go',
  'lua',
  'markdown',
  'markdown_inline',
  'python',
  'rust',
  'tsx',
  'typescript',
}

local function start(buf, lang)
  if not vim.api.nvim_buf_is_valid(buf) or not pcall(vim.treesitter.start, buf, lang) then
    return false
  end

  vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  if lang == 'markdown' then
    -- keep regex highlighting alongside tree-sitter
    vim.bo[buf].syntax = 'ON'
  end
  return true
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('my-treesitter', { clear = true }),
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(ev.match)
    if not lang or start(ev.buf, lang) then
      return
    end

    -- equivalent of the old `auto_install = true`
    if vim.list_contains(ts.get_available(), lang) then
      ts.install(lang):await(function(err)
        if not err then
          vim.schedule(function()
            start(ev.buf, lang)
          end)
        end
      end)
    end
  end,
})
