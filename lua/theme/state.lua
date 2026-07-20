-- Persists the active theme name across restarts (see :SetTheme in lua/commands.lua).
local M = {}

local path = vim.fn.stdpath "state" .. "/nvim-config-theme"

M.read = function(default)
  local file = io.open(path, "r")
  if not file then
    return default
  end
  local name = file:read "*l"
  file:close()
  return name or default
end

M.write = function(name)
  local file = io.open(path, "w")
  if file then
    file:write(name)
    file:close()
  end
end

return M
