vim.opt_local.wrap = true -- Enable visual line wrapping
vim.opt_local.textwidth = 80 -- Set maximum text width to 80 for automatic formatting
vim.opt_local.formatoptions = "t" -- Enable automatic wrapping at 'textwidth' while typing
vim.opt_local.linebreak = true

vim.keymap.set({ "n", "o", "x" }, "j", "gj", {}) -- Move down a visual line
vim.keymap.set({ "n", "o", "x" }, "k", "gk", {}) -- Move up a visual line
vim.keymap.set({ "n", "o", "x" }, "H", "g0", {}) -- Move to beginning of visual line
vim.keymap.set({ "n", "o", "x" }, "L", "g$", {}) -- Move to end of visual line
