vim.o.background = "dark"
vim.o.termguicolors = true

local apply = require "theme.apply"
apply(require "themes.onedark")

-- must come after apply()'s "hi clear", which resets g:colors_name as a side effect
vim.g.colors_name = "onedark"
