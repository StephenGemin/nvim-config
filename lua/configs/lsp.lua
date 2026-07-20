-- https://github.com/saghen/blink.cmp/blob/78336bc89ee5365633bcf754d93df01678b5c08f/doc/configuration/snippets.md#L145-L149
local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gr", vim.lsp.buf.references, "References")
    map("n", "K", vim.lsp.buf.hover, "Hover")
    map("n", "<leader>D", vim.lsp.buf.type_definition, "Type definition")
    map("n", "<leader>ra", vim.lsp.buf.rename, "Rename")
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
    map("n", "<leader>wl", function()
      vim.print(vim.lsp.buf.list_workspace_folders())
    end, "List workspace folders")
  end,
})

vim.lsp.config("*", { capabilities = capabilities })

vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅙",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "󰋼",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
  },
  underline = true,
  virtual_lines = { current_line = true },
  float = { border = "single" },
}

vim.lsp.enable { "lua_ls" }
