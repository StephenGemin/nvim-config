vim.g.mapleader = " "

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

require("lazy").setup("plugins", lazy_config)

vim.cmd.colorscheme(require("theme.state").read "onedark")

require "options"
require "autocmds"
require "commands"

vim.schedule(function()
  require "mappings"
end)
