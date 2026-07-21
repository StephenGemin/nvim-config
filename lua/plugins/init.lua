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

  {
    -- eager: telescope and nvim-tree both check for devicons opportunistically on render
    -- (not just once at their own setup), so it must already be loaded before either first draws
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    opts = {},
  },

  {
    -- eager + high priority: the dashboard replaces the empty startup buffer, so it must be
    -- ready before any lazy-loading event fires
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = require "configs.dashboard",
      terminal = require "configs.terminal",
    },
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

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- config (not opts): configs.telescope references telescope.actions, which isn't
    -- on the runtimepath until this plugin loads
    config = function()
      require("telescope").setup(require "configs.telescope")
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    -- no lua/configs/gitsigns.lua: only override is the delete/changedelete sign glyphs
    -- (matching NvChad's), everything else is plugin defaults
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        delete = { text = "󰍵" },
        changedelete = { text = "󱕖" },
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = require "configs.nvimtree",
  },

  {
    "brenoprata10/nvim-highlight-colors",
    -- no lua/configs/highlight-colors.lua: plugin defaults (hex/rgb/hsl/named colors on,
    -- tailwind/ansi off) already cover this repo's needs; no further configuration needed
    -- VeryLazy (not BufReadPre/BufNewFile): setup() retroactively highlights every open buffer,
    -- so it must fire even on a no-file startup session that never triggers a buf-read event
    event = "VeryLazy",
    opts = {},
  },

  {
    "folke/which-key.nvim",
    -- no keys = {...} block (upstream's README suggests one for <leader>?): global leader
    -- bindings belong in lua/mappings.lua, not scattered across plugin specs (see Phase 7)
    event = "VeryLazy",
    opts = {},
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    -- main = "ibl": the plugin's actual module name differs from its repo name (it also ships a
    -- legacy v2 compat shim lazy.nvim could otherwise auto-detect); matches upstream's own spec
    main = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    -- config (not opts): configs["indent-blankline"] references ibl.hooks, which isn't
    -- on the runtimepath until this plugin loads
    config = function()
      require "configs.indent-blankline"
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    -- config (not opts): registers a ColorScheme autocmd so lualine's "auto" theme
    -- follows :SetTheme switches, not just plain opts
    config = function()
      require "configs.lualine"
    end,
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = require "configs.bufferline",
  },

  {
    -- eager: mappings.lua requires it at top level (resize/move-cursor keymaps),
    -- not inside a lazy-loaded closure
    "mrjones2014/smart-splits.nvim",
    lazy = false,
  },
}
