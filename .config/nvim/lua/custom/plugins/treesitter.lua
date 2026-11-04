-- nvim-treesitter's `main` branch only installs parsers and queries;
-- highlighting is Neovim's builtin, started per buffer below.
local ts = require 'nvim-treesitter'

-- Parsers are compiled with the tree-sitter CLI (Brewfile / packages.txt).
-- Without it, warn once and only use parsers that are already installed.
local can_install = vim.fn.executable 'tree-sitter' == 1
if not can_install then
  vim.notify(
    'tree-sitter CLI not found; skipping parser installs (brew/pacman install tree-sitter-cli)',
    vim.log.levels.WARN
  )
end

local function install(langs)
  if can_install then
    return ts.install(langs)
  end
end

install {
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

  -- Injected into the languages above (Dockerfile RUN lines, regexes, format
  -- strings, doc comments, code fences). The FileType auto-install below
  -- never sees these, so without them those regions stay unhighlighted.
  'bash',
  'comment',
  'css',
  'html',
  'jsdoc',
  'json',
  'luadoc',
  'luap',
  'printf',
  'query',
  'regex',
  'toml',
  'vim',
  'vimdoc',
  'yaml',
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
    if can_install and vim.list_contains(ts.get_available(), lang) then
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
