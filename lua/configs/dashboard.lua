-- Subtle blue -> lavender gradient for the header, built from onedark's own
-- blue/purple accent colors (base46/themes/onedark.lua) so it reads as part
-- of the theme rather than a bolted-on rainbow.
local gradient = { "#61afef", "#7aaaf2", "#93a6f5", "#aca1f7", "#c59dfa", "#de98fd" }
local function set_header_highlights()
  for i, hex in ipairs(gradient) do
    vim.api.nvim_set_hl(0, "DashboardHeader" .. i, { fg = hex })
  end
end

set_header_highlights()

-- colors/onedark.lua's "hi clear" (run right after this module loads, during init.lua's
-- own startup sequence) wipes these groups before the dashboard ever paints -- reapply on
-- every ColorScheme event.
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_header_highlights,
})

return {
  enabled = true,
  preset = {
    header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
  },
  formats = {
    -- One shade per line (top to bottom) instead of a single flat color.
    -- snacks only starts a new row on a literal "\n" inside one Text's
    -- string, so each line after the first needs a leading "\n" to land on
    -- its own row. That leading "\n" splits off an empty first piece which
    -- inherits this text's own width/align -- if those were set, snacks pads
    -- that empty piece out to a full-width blank span and appends it to the
    -- *previous* line's row, silently doubling that row's tracked width and
    -- throwing off centering on the rows that follow. So width/align are
    -- left unset (the empty piece then contributes zero width) and each line
    -- is centered manually instead.
    header = function(item, ctx)
      local lines = vim.split(item.header, "\n", { plain = true })
      local out = {}
      for i, line in ipairs(lines) do
        local pad = math.max(0, math.floor((ctx.width - vim.api.nvim_strwidth(line)) / 2))
        local prefix = i > 1 and "\n" or ""
        out[#out + 1] = { prefix .. (" "):rep(pad) .. line, hl = "DashboardHeader" .. i }
      end
      return out
    end,
  },
  -- Two-pane layout: shortcuts on the left, recent activity on the right.
  sections = {
    { section = "header" },
    -- NvChad's dashboard footer trick: the nvim logo glyph stands in for the "N" in
    -- "Neovim" ("eovim" + glyph reads as "Neovim").
    { align = "center", padding = 1, text = { { " Powered By eovim", hl = "footer" } } },
    { section = "keys", gap = 1, padding = 1 },
    { section = "startup" },
    { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
    { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
    {
      pane = 2,
      icon = " ",
      title = "Git Status",
      section = "terminal",
      enabled = function()
        return Snacks.git.get_root() ~= nil
      end,
      cmd = "git status --short --branch --renames",
      height = 5,
      padding = 1,
      ttl = 5 * 60,
      indent = 3,
    },
    -- Resolves at dashboard render time, after lazy.manage.checker is loadable.
    function()
      local ok, checker = pcall(require, "lazy.manage.checker")
      if not ok or #checker.updated == 0 then
        return {}
      end
      local items = {
        { pane = 2, icon = "󰂠 ", title = "Plugin Updates", indent = 2, padding = 1 },
      }
      for i = 1, math.min(5, #checker.updated) do
        items[#items + 1] = { pane = 2, indent = 2, text = checker.updated[i], action = ":Lazy" }
      end
      return items
    end,
  },
}
