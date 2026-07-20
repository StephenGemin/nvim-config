-- main-branch nvim-treesitter has no `ensure_installed` setup option; installing
-- parsers is an explicit, async, idempotent call instead (no-op if already installed)
require("nvim-treesitter").install {
  "vim",
  "lua",
  "vimdoc",
  "html",
  "css",
  "luadoc",
  "printf",
}
