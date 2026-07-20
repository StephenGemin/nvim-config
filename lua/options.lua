local opt = vim.opt

opt.laststatus = 3
opt.showmode = false
opt.splitkeep = "screen"

opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.cursorlineopt = "number"

-- indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

opt.number = true
opt.numberwidth = 2
opt.ruler = false

opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.timeoutlen = 400
opt.undofile = true

-- swap-file write interval; also used by gitsigns to debounce its updates
opt.updatetime = 250

-- move to previous/next line with h/l/left/right at the start/end of a line
opt.whichwrap:append "<>[]hl"

vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- load-bearing: without this, LSP servers/formatters installed via mason.nvim
-- aren't found on $PATH
local path_sep = vim.fn.has "win32" == 1 and "\\" or "/"
local path_delim = vim.fn.has "win32" == 1 and ";" or ":"
local mason_bin = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, path_sep)
vim.env.PATH = mason_bin .. path_delim .. vim.env.PATH
