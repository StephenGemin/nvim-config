-- built-in branch/diff/diagnostics components already cover NVChad's old statusline git info;
-- no LSP-progress spinner (would need a custom component or an extra plugin like fidget.nvim)
local colors = require("themes.onedark").base_30

-- lualine falls back to `normal`'s b/c highlights for any mode that doesn't define its own
-- (see lualine/highlight.lua's format_highlight), so only `a` needs setting per mode.
local theme = {
  normal = {
    a = { fg = colors.black, bg = colors.nord_blue, gui = "bold" },
    b = { fg = colors.white, bg = colors.lightbg },
    c = { fg = colors.light_grey, bg = colors.statusline_bg },
  },
  insert = { a = { fg = colors.black, bg = colors.dark_purple, gui = "bold" } },
  visual = { a = { fg = colors.black, bg = colors.cyan, gui = "bold" } },
  replace = { a = { fg = colors.black, bg = colors.orange, gui = "bold" } },
  command = { a = { fg = colors.black, bg = colors.green, gui = "bold" } },
  terminal = { a = { fg = colors.black, bg = colors.green, gui = "bold" } },
  inactive = {
    a = { fg = colors.light_grey, bg = colors.statusline_bg },
    b = { fg = colors.light_grey, bg = colors.statusline_bg },
    c = { fg = colors.light_grey, bg = colors.statusline_bg },
  },
}

-- No custom component_separators/section_separators: lualine's own defaults are already
-- the powerline glyphs this phase wanted.
return {
  options = {
    theme = theme,
  },
}
