# Neovim Config

This config targets Neovim 0.12+ and intentionally keeps the plugin set small.
Most editing, LSP, completion, formatting, diagnostics, Tree-sitter, undo, and
navigation behavior now comes from Neovim itself.

## Remaining Plugins

Plugins are managed by Neovim's built-in `vim.pack` in `lua/custom/pack.lua`.

- `nvim-telescope/telescope.nvim`: fuzzy file, grep, help, and diagnostic pickers.
- `nvim-lua/plenary.nvim`: Telescope dependency.
- `nvim-treesitter/nvim-treesitter`: manages Tree-sitter parsers and queries.
- `tpope/vim-fugitive`: Git porcelain inside Neovim.
- `lewis6991/gitsigns.nvim`: inline Git hunk signs.

Use `:PackUpdate` to inspect available plugin updates; select updates in its
report buffer. Use `:PackUpdate!` to apply every available update immediately.
`vim.pack` reports install and update events in Neovim notifications.

## Removed Plugin Replacements

### LSP and Mason

Mason, mason-lspconfig, mason-tool-installer, and nvim-lspconfig were removed.
Language servers are now configured through native `vim.lsp.config()` and
enabled with `vim.lsp.enable()`.

Install servers with system packages instead:

```sh
sudo pacman -S clang gopls lua-language-server pyright rust-analyzer zls
sudo pacman -S typescript-language-server
```

If a package is unavailable on your machine, use the language ecosystem package:

```sh
npm install -g typescript typescript-language-server pyright
```

Useful native LSP defaults:

- `K`: hover documentation.
- `<C-]>`: go to definition through the LSP tag function.
- `grn`: rename.
- `gra`: code action.
- `grr`: references.
- `gri`: implementation.
- `grt`: type definition.
- `gO`: document symbols.
- Insert mode `<C-s>`: signature help.
- `:Format`: format the current buffer with the attached LSP.
- `<leader>th`: toggle inlay hints when the server supports them.
- `:checkhealth vim.lsp`: inspect LSP setup and missing servers.

### Completion and Snippets

nvim-cmp, cmp-nvim-lsp, cmp-path, cmp-buffer, LuaSnip, and cmp_luasnip were
removed. Native LSP completion is enabled on attach.

Native completion keys:

- `<C-x><C-o>`: request LSP omni completion.
- `<C-x><C-f>`: complete file paths.
- `<C-x><C-l>`: complete whole lines.
- `<C-n>` / `<C-p>`: select next/previous completion item.
- `<C-y>`: accept selected completion.
- `<C-e>`: cancel completion.

The old cmp path-completion workflow is now `<C-x><C-f>`.

### Diagnostics and Trouble

Trouble was removed. Diagnostics now use native diagnostic floats plus
location/quickfix lists.

- `<leader>d`: show diagnostic under the cursor.
- `<leader>q`: populate the location list with diagnostics.
- `:lopen`: open the location list.
- `:lclose`: close the location list.
- `:lnext` / `:lprev`: move through location-list entries.
- `:copen`: open the quickfix list.
- `:cnext` / `:cprev`: move through quickfix entries.

### Tree-sitter

Neovim's native Tree-sitter engine performs highlighting and parsing. The
eagerly loaded `nvim-treesitter` dependency manages version-compatible parsers
and query files; it does not replace Neovim's highlighter. Rust is installed
automatically. Install additional languages as needed:

```vim
:TSInstall javascript python cpp go typescript tsx zig
```

The installer requires `tree-sitter-cli`, `curl`, `tar`, and a C compiler. Run
`:TSUpdate` after updating `nvim-treesitter` (the `vim.pack` notification
reminds you). The config reports missing parsers or highlight queries once per
language; run `:TreesitterStatus` in a buffer to inspect its current status.

### Formatting and Conform

conform.nvim was removed. Buffers format on save with the attached LSP when the
server supports formatting. `:Format` runs `vim.lsp.buf.format()` manually.

Optional external formatters:

```sh
sudo pacman -S stylua gofumpt python-black python-isort prettier
rustup component add rustfmt
```

Use those from the shell, project tooling, or a language server that delegates to
them. The Neovim config no longer installs formatters automatically.

### Harpoon

Harpoon was removed. Native replacements:

- `mA`, `mB`, etc.: set uppercase global marks.
- `'A` or `` `A ``: jump to an uppercase mark.
- `:marks`: list marks.
- `<C-^>`: jump to the alternate file.
- `<C-o>` / `<C-i>`: move backward/forward through the jumplist.
- `:args file1 file2`: define a small working set.
- `:next` / `:prev`: move through the arglist.
- `:buffers`, `:buffer {name}`, `:bnext`, `:bprev`: use buffers as the working set.

### Undotree

The undotree plugin was removed. Use Neovim's built-in command:

- `:Undotree`: open the native undo tree view.
- `g-` / `g+`: move backward/forward through undo branches.

### Lualine

[`nvim-lualine/lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim) is
installed through `vim.pack` and uses the TokyoNight theme.

### Todo Comments

todo-comments.nvim was removed. Native/Telescope replacements:

- `:grep TODO`
- `:grep FIXME`
- `<leader>sg` with Telescope live grep.
- `<leader>sw` with the cursor on `TODO`, `FIXME`, etc.

### Indent Helpers

indent-blankline.nvim and guess-indent.nvim were removed. Indentation now comes
from native options in `lua/custom/set.lua` and filetype defaults.

Useful commands:

- `:setlocal shiftwidth=2 tabstop=2 softtabstop=2`
- `:setlocal noexpandtab`
- `gg=G`: reindent the whole file.

### Colorscheme

[`folke/tokyonight.nvim`](https://github.com/folke/tokyonight.nvim) is installed
through `vim.pack` and configured with its `night` style.

## Telescope Keys Kept For Now

- `<leader>gf`: Git-tracked files.
- `<leader>sf`: files.
- `<leader>sd`: diagnostics.
- `<leader>sh`: help tags.
- `<leader>sw`: grep word under cursor.
- `<leader>sg`: live grep.
- `<leader>/`: fuzzy search current buffer.

Native alternatives to practice:

- `:find name<Tab>`: find files using `'path'`.
- `:edit **/name<Tab>`: edit by recursive path completion.
- `:grep pattern`: search using `'grepprg'` and populate quickfix.
- `:vimgrep /pattern/ **/*`: built-in grep without external grep.
- `:copen`, `:cnext`, `:cprev`: inspect grep results.
- `:help topic<Tab>`: help completion.

## Git

Fugitive and Gitsigns stay.

- `<leader>gs`: open Fugitive Git status.
- Inside Fugitive status, `<leader>p`: `git push`.
- Inside Fugitive status, `<leader>P`: `git pull --rebase`.

Native/terminal alternatives:

- `:terminal git status`
- `:terminal git diff`
- `:make` with a project-specific `makeprg`

## Existing Personal Keys

- `-`: open netrw file explorer.
- `<C-d>` / `<C-u>`: half-page down/up and recenter.
- `<C-f>`: open `tmux-sessionizer` in a new tmux window.
- `<Esc><Esc>` in terminal mode: return to normal mode.
- `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`: move between windows.
- `<leader>w`: toggle wrap and linebreak.
