-- main-branch nvim-treesitter has no `ensure_installed` setup option; installing
-- parsers is an explicit, async, idempotent call instead (no-op if already installed)
local parsers = {
  "vim",
  "lua",
  "vimdoc",
  "html",
  "css",
  "luadoc",
  "printf",
  "typescript",
  "tsx",
  "javascript",
  "json",
  "yaml",
  "go",
  "gomod",
  "gosum",
  "gowork",
  "rust",
  "bash",
  "toml",
  "python",
  "c_sharp",
  "c",
  "cpp",
  "markdown",
  "markdown_inline",
}

local install_task = require("nvim-treesitter").install(parsers)

-- exposed so scripts/smoke_test.lua can block on the same task and verify
-- installs actually succeeded, rather than duplicating this list.
-- `require` only ever surfaces a module's first return value, so this has
-- to be a single table rather than `return parsers, install_task`.
return { parsers = parsers, task = install_task }
