local normal_hl = vim.api.nvim_get_hl(0, { name = 'Normal' })
local comment_hl = vim.api.nvim_get_hl(0, { name = 'Comment' })
vim.api.nvim_set_hl(0, 'StatusLine', { fg = normal_hl.fg, bg = 'NONE' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = comment_hl.fg or normal_hl.fg, bg = 'NONE' })

local mode_names = {
  n = 'NORMAL',
  no = 'OP-PENDING',
  nov = 'OP-PENDING',
  noV = 'OP-PENDING',
  ['no\022'] = 'OP-PENDING',
  niI = 'NORMAL',
  niR = 'NORMAL',
  niV = 'NORMAL',
  nt = 'NORMAL',
  v = 'VISUAL',
  vs = 'VISUAL',
  V = 'V-LINE',
  Vs = 'V-LINE',
  ['\022'] = 'V-BLOCK',
  ['\022s'] = 'V-BLOCK',
  s = 'SELECT',
  S = 'S-LINE',
  ['\019'] = 'S-BLOCK',
  i = 'INSERT',
  ic = 'INSERT',
  ix = 'INSERT',
  R = 'REPLACE',
  Rc = 'REPLACE',
  Rx = 'REPLACE',
  Rv = 'V-REPLACE',
  Rvc = 'V-REPLACE',
  Rvx = 'V-REPLACE',
  c = 'COMMAND',
  cv = 'EX',
  ce = 'EX',
  r = 'PROMPT',
  rm = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  t = 'TERMINAL',
}

function _G.custom_statusline()
  local mode = mode_names[vim.api.nvim_get_mode().mode] or vim.api.nvim_get_mode().mode
  local branch = ''

  if vim.fn.exists '*FugitiveHead' == 1 then
    local head = vim.fn.FugitiveHead()
    if head ~= '' then
      branch = '  git:' .. head
    end
  end

  return table.concat {
    ' ',
    mode,
    branch,
    '  %f',
    '%m',
    '%r',
    '%=',
    '%y',
    ' %{&fileencoding?&fileencoding:&encoding}',
    ' [%l:%c] ',
  }
end

vim.o.statusline = '%!v:lua.custom_statusline()'
