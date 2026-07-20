return {
  formatters_by_ft = {
    lua = { "stylua" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    yaml = { "prettier" },
    go = { "goimports", "gofumpt" },
    rust = { "rustfmt" },
    python = { "ruff_format" },
    cs = { "csharpier" },
    c = { "clang-format" },
    cpp = { "clang-format" },
  },
  format_on_save = {
    lsp_fallback = true,
  },
}
