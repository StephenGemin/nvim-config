# nvim-config

Stephen Gemin's personal Neovim configuration — self-managed, with no framework (NVChad,
LazyVim, etc.) sitting between this repo and its plugins. Replaces `nvim-starter`, a thin
NVChad wrapper; see commit history for how each piece got ported over.

## Project goals

- Full ownership: every plugin choice and config file lives in this repo, understood and
  modifiable, not inherited from a framework's compiled defaults.
- Colemak-DH-friendly keymaps and a hand-written onedark-derived colorscheme.
- Fast, minimal startup — lazy-load everything that isn't needed at boot.

## Project structure

```
init.lua                    entry point: mapleader, lazy.nvim bootstrap, colorscheme,
                             require("lazy").setup("plugins", ...), require "options"/"autocmds"/
                             "commands", scheduled require "mappings"
lua/options.lua              vim.opt settings, Mason $PATH prepend
lua/autocmds.lua             FileType treesitter-start, parser-rebuild-on-upgrade
lua/commands.lua             :SetTheme user command (wraps vim.cmd.colorscheme + persists choice)
lua/mappings.lua              ; -> :, Colemak-DH block, smart-splits resize/move/swap, jumplist
                             (<C-Left>/<C-Right>), comment toggle, buffers, terminal, telescope
                             pickers, nvim-tree, format, diagnostics loclist, which-key
lua/plugins/init.lua          lazy.nvim plugin spec: blink.cmp, nvim-treesitter, nvim-web-devicons,
                             snacks.nvim (eager), nvim-lspconfig, mason.nvim, conform.nvim,
                             nvim-autopairs, telescope.nvim, gitsigns.nvim, nvim-tree.lua,
                             nvim-highlight-colors, which-key.nvim, indent-blankline.nvim,
                             lualine.nvim, bufferline.nvim (lazy), smart-splits.nvim (eager)
lua/configs/lazy.lua          lazy.nvim setup options (UI, performance, disabled builtin plugins)
lua/configs/lsp.lua           LspAttach keymaps, blink.cmp capabilities, diagnostic config,
                             vim.lsp.enable {...} server list
lua/configs/treesitter.lua    require("nvim-treesitter").install {...} parser list
lua/configs/mason.lua         static ensure_installed list (LSP servers + formatters)
lua/configs/conform.lua       formatters_by_ft, format_on_save
lua/configs/telescope.lua     sorting/layout opts, q closes in normal mode
lua/configs/nvimtree.lua      my_on_attach (default keymaps + Colemak e->,,, rename remap),
                             filters.git_ignored = false
lua/configs/indent-blankline.lua  hide_first_space_indent_level hook, then ibl.setup {}
lua/configs/lualine.lua       theme = "auto", rerun on ColorScheme so :SetTheme switches apply
lua/configs/bufferline.lua    options.offsets for nvim-tree's sidebar
lua/configs/terminal.lua      Snacks.terminal's opts.terminal (bottom split, 30% height)
lua/configs/dashboard.lua     Snacks.dashboard's opts.dashboard (header, keys/recent-files/
                             projects/git-status panes), ported verbatim from nvim-starter
lsp/lua_ls.lua                per-server vim.lsp.config override (auto-discovered by name)
colors/onedark.lua            thin :colorscheme wrapper: sets colors_name/background, calls theme.apply
lua/themes/onedark.lua        onedark palette (base_30/base_16-style tables)
lua/theme/apply.lua           shared highlight-group-applying logic, parameterized on a palette
lua/theme/state.lua           persists :SetTheme's active theme name across restarts
tests/theme_spec.lua          plenary.nvim busted-style spec: :SetTheme + theme/state.lua persistence
```

Other LSP servers (html, cssls, ts_ls, jsonls, yamlls, gopls, rust_analyzer, bashls, taplo,
pyright, ruff, omnisharp) are enabled in `lua/configs/lsp.lua` with no local `lsp/<name>.lua`
override — nvim-lspconfig ships complete `cmd`/`filetypes`/`root_markers` defaults for all of
them on its own runtimepath, which `vim.lsp.config` merges automatically. Only add a file
under `lsp/` for a server when it needs a genuine override, as `lua_ls.lua` does.

gitsigns.nvim and nvim-highlight-colors have no dedicated `lua/configs/*.lua` file, configured
inline via `opts = {...}` in `lua/plugins/init.lua` instead — plugin defaults already cover this
repo's needs, aside from gitsigns' delete/changedelete sign glyphs (matching NvChad's).

`vim.lsp.buf.rename` (`<leader>ra`) is a buffer-local LSP keymap set in `lua/configs/lsp.lua`,
not in `lua/mappings.lua`. Update this map whenever a module is added, removed, or moved.

## Reading this repo efficiently

Small repo, no framework indirection: reading the file you're changing plus its direct
`require`s is normally enough.

## Build and lint

```sh
stylua --check .
```

CI (`.github/workflows/ci.yml`) runs this on every push/PR to `main`.

## Code style

- Lua, 2-space indent — `.stylua.toml` is authoritative for formatting.
- No global variables, mutable or otherwise; keep state local to a module/closure and expose
  a setter function if something outside the module genuinely needs to change it.
- Comments only where the *why* isn't obvious from the code (a workaround, a hidden
  constraint, a subtle invariant) — not restating what a line does.

## What requires a conversation first

- Swapping the plugin manager, colorscheme approach, or any other piece named in the project
  goals above.
- Adding a new plugin dependency.
- Any refactor spanning more than two files in the structure map above.

## What to avoid

- Reaching for a framework helper (NVChad, LazyVim, etc.) instead of writing the config
  directly — the whole point of this repo is owning that code.
