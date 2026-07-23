return {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          vim.fn.stdpath "data" .. "/lazy/snacks.nvim/lua/snacks",
          "${3rd}/luv/library",
          vim.fn.expand "~/.config/wezterm-types",
        },
      },
    },
  },
}
