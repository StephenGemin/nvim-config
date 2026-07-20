local M = {}

M.ensure_installed = {
  "lua-language-server",
  "stylua",
}

function M.setup()
  require("mason").setup()

  local registry = require "mason-registry"
  registry.refresh(function()
    for _, name in ipairs(M.ensure_installed) do
      local pkg = registry.get_package(name)
      if not pkg:is_installed() then
        pkg:install()
      end
    end
  end)
end

return M
