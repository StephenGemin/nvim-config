local M = {}

M.ensure_installed = {
  "lua-language-server",
  "stylua",
  "html-lsp",
  "css-lsp",
  "typescript-language-server",
  "json-lsp",
  "yaml-language-server",
  "gopls",
  "rust-analyzer",
  "bash-language-server",
  "taplo",
  "pyright",
  "ruff",
  "omnisharp",
  "clangd",
  "prettier",
  "gofumpt",
  "goimports",
  "csharpier",
  "clang-format",
  -- rustfmt has no mason package (ships via rustup); install with `rustup component add rustfmt`
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
