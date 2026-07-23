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

local function lsp_client()
  local clients = vim.lsp.get_clients { bufnr = 0 }
  return clients[1] and ("  LSP ~ " .. clients[1].name .. " ") or ""
end

local function cwd()
  return "󰉋 " .. vim.fn.fnamemodify(vim.uv.cwd(), ":t")
end

-- No custom component_separators/section_separators: lualine's own defaults are already
-- the powerline glyphs this phase wanted.
return {
  options = {
    theme = theme,
    -- snacks.nvim's dashboard zeroes laststatus at startup and restores it later, so
    -- lualine's own default (`vim.go.laststatus == 3`, read once at setup time) can catch
    -- that transient 0 and latch onto a per-window statusline instead of the global one
    globalstatus = true,
  },
  -- Stock lualine right side (encoding, fileformat, filetype, progress) is almost always
  -- the same value (utf-8/unix) or redundant with location -- swap it for LSP client name
  -- and cwd, which are actually useful.
  sections = {
    lualine_x = { lsp_client, cwd },
    lualine_y = {},
  },
}
