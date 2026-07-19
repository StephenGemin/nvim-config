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
init.lua               entry point: mapleader, lazy.nvim bootstrap, require("lazy").setup(...)
lua/configs/lazy.lua    lazy.nvim setup options (UI, performance, disabled builtin plugins)
```

This is early — options, autocmds, mappings, LSP config, and the actual plugin spec land in
follow-up commits. Update this map whenever a module is added, removed, or moved.

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
