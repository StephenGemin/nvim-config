local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

-- Colemak-DH: hjkl land off home row on this layout, so n/e/i/o (the actual
-- home-row keys) take over left/down/up/right movement below. That frees "fp"
-- as an <ESC> chord (roll off the home row, like "jk" on QWERTY) and bumps
-- vim's i/o (insert/open-line) off their usual keys, so s/S/t/T are
-- repurposed for those below (see "Insert/new line").
local left = "n"
local down = "e"
local up = "i"
local right = "o"
map("i", "fp", "<ESC>")

-- -- QWERTY
-- local left = "h"
-- local down = "j"
-- local up = "k"
-- local right = "l"
-- map("i", "jk", "<ESC>")

-- Up/down/left/right
map({ "n", "o", "x" }, left, "h", { desc = "Left (h)" })
map({ "n", "o", "x" }, down, "j", { desc = "Down (j)" })
-- Normal mode only: "i" must stay free as the inner-text-object prefix
-- (diw, ci(, vip, ...) in Operator-pending/Visual mode.
map("n", up, "k", { desc = "Up (k)" })
map({ "n", "o", "x" }, right, "l", { desc = "Right (l)" })

-- Insert mode: Ctrl + navigation
map("i", "<C-" .. left .. ">", "<Left>", { desc = "Move left" })
map("i", "<C-" .. down .. ">", "<Down>", { desc = "Move down" })
map("i", "<C-" .. up .. ">", "<Up>", { desc = "Move up" })
map("i", "<C-" .. right .. ">", "<Right>", { desc = "Move right" })

-- Insert/new line
map("n", "s", "i") -- switch to insert mode before the cursor
map("n", "S", "I") -- insert text at the beginning of the line
map("n", "t", "o") -- open a new line below the current one
map("n", "T", "O") -- open a new line above the current one

-- resizing splits from smart-splits
-- these keymaps will also accept a range,
-- for example `10<A-n>` will `resize_left` by `(10 * config.default_amount)`
map("n", "<A-" .. left .. ">", require("smart-splits").resize_left)
map("n", "<A-" .. down .. ">", require("smart-splits").resize_down)
map("n", "<A-" .. up .. ">", require("smart-splits").resize_up)
map("n", "<A-" .. right .. ">", require("smart-splits").resize_right)
-- moving between splits
map("n", "<C-" .. left .. ">", require("smart-splits").move_cursor_left)
map("n", "<C-" .. down .. ">", require("smart-splits").move_cursor_down)
map("n", "<C-" .. up .. ">", require("smart-splits").move_cursor_up)
map("n", "<C-" .. right .. ">", require("smart-splits").move_cursor_right)
map("n", "<C-\\>", require("smart-splits").move_cursor_previous)
-- swapping buffers between windows
map("n", "<leader><leader>" .. left, require("smart-splits").swap_buf_left)
map("n", "<leader><leader>" .. down, require("smart-splits").swap_buf_down)
map("n", "<leader><leader>" .. up, require("smart-splits").swap_buf_up)
map("n", "<leader><leader>" .. right, require("smart-splits").swap_buf_right)

-- QWERTY
-- -- resizing splits
-- -- these keymaps will also accept a range,
-- -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
-- map('n', '<A-h>', require('smart-splits').resize_left)
-- map('n', '<A-j>', require('smart-splits').resize_down)
-- map('n', '<A-k>', require('smart-splits').resize_up)
-- map('n', '<A-l>', require('smart-splits').resize_right)
-- -- moving between splits
-- map('n', '<C-h>', require('smart-splits').move_cursor_left)
-- map('n', '<C-j>', require('smart-splits').move_cursor_down)
-- map('n', '<C-k>', require('smart-splits').move_cursor_up)
-- map('n', '<C-l>', require('smart-splits').move_cursor_right)
-- map('n', '<C-\\>', require('smart-splits').move_cursor_previous)
-- -- swapping buffers between windows
-- map('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
-- map('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
-- map('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
-- map('n', '<leader><leader>l', require('smart-splits').swap_buf_right)

-- Jumplist back/forward: native <C-o>/<C-i> are claimed above by smart-splits'
-- move_cursor_up/move_cursor_right on this layout, and WezTerm intercepts <C-i>/<C-o>
-- at the terminal level too, so neither has a working fallback. Arrow keys are a
-- separate keycode namespace from n/e/i/o and layout-independent (no QWERTY variant
-- needed).
map("n", "<C-Left>", "<C-o>", { desc = "Jump back" })
map("n", "<C-Right>", "<C-i>", { desc = "Jump forward" })

-- Comment toggle: native 0.10+ gc operator, no plugin needed
map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- Buffers (bufferline.nvim's user commands, not its Lua API directly -- keeps this
-- file free of a hard require on a lazy-loaded plugin)
-- Bracket pair, not <tab>/<S-tab>: <Tab> and <C-i> are the same keycode, and
-- <C-i> is already move_cursor_up above -- <tab> here would silently win and kill it.
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "Buffer new" })
map("n", "]b", "<cmd>BufferLineCycleNext<CR>", { desc = "Buffer goto next" })
map("n", "[b", "<cmd>BufferLineCyclePrev<CR>", { desc = "Buffer goto prev" })
map("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Buffer close" })

-- Terminal (Snacks.terminal, see configs/terminal.lua for the window config)
map("n", "<leader>t", function()
  Snacks.terminal.toggle()
end, { desc = "Terminal toggle" })
map("t", "<C-x>", "<C-\\><C-n>", { desc = "Terminal escape terminal mode" })

-- nvim-tree
-- <C-t>, not NVChad's <C-n>: "n" is move_cursor_left above on this layout.
map("n", "<C-t>", "<cmd>NvimTreeToggle<CR>", { desc = "Nvim-tree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Nvim-tree focus window" })

-- telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "Telescope find all files" }
)
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope help page" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Telescope find in current buffer" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "Telescope find marks" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "Telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Telescope git status" })

-- format
map({ "n", "x" }, "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format file" })

-- diagnostics
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "Diagnostic loclist" })

-- which-key
map("n", "<leader>wK", "<cmd>WhichKey<CR>", { desc = "WhichKey all keymaps" })
map("n", "<leader>wk", function()
  vim.ui.input({ prompt = "WhichKey: " }, function(query)
    if query then
      vim.cmd.WhichKey(query)
    end
  end)
end, { desc = "WhichKey query lookup" })
