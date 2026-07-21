-- built-in branch/diff/diagnostics components already cover NVChad's old statusline git info;
-- no LSP-progress spinner (would need a custom component or an extra plugin like fidget.nvim)
local config = {
  options = { theme = "auto" },
}

require("lualine").setup(config)

-- "auto" derives colors from the active colorscheme's highlight groups once, at setup() time --
-- rerun with the same config on :SetTheme/:colorscheme switches so lualine's colors follow.
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    require("lualine").setup(config)
  end,
})
