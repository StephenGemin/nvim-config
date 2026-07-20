return {
  -- EAGER LOAD (lazy = false) --

  {
    "saghen/blink.cmp",
    -- v2/main is under active, breaking development; v1 is the last stable line
    version = "1.*",
    lazy = false,
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {},
  },

  {
    -- upstream doesn't support lazy-loading on the main branch
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require "configs.treesitter"
    end,
  },

  -- LAZY LOAD (event/cmd-gated) --

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    -- declared as a dependency (not just relying on blink's own lazy = false) so lazy.nvim
    -- structurally guarantees blink.cmp is loaded before configs.lsp requires it for capabilities
    dependencies = { "saghen/blink.cmp" },
    config = function()
      require "configs.lsp"
    end,
  },

  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    config = function()
      require("configs.mason").setup()
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
}
