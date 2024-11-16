-- vim.opt_local.wrap = true -- Enable visual line wrapping
-- vim.opt_local.textwidth = 80 -- Set maximum text width to 80 for automatic formatting
-- vim.opt_local.formatoptions = "t" -- Enable automatic wrapping at 'textwidth' while typing
-- vim.opt_local.linebreak = true
--
-- vim.keymap.set({ "n", "o", "x" }, "j", "gj", {}) -- Move down a visual line
-- vim.keymap.set({ "n", "o", "x" }, "k", "gk", {}) -- Move up a visual line
-- vim.keymap.set({ "n", "o", "x" }, "H", "g0", {}) -- Move to beginning of visual line
-- vim.keymap.set({ "n", "o", "x" }, "L", "g$", {}) -- Move to end of visual line

vim.opt_local.wrap = true

-- Break lines visually at word boundaries instead of splitting words
vim.opt_local.linebreak = true

-- Disable automatic newline insertion when typing
vim.opt_local.textwidth = 0
vim.opt_local.formatoptions:remove("t") -- Avoid text wrapping while typing

-- Optional: Highlight the 80th character as a visual guide
vim.opt_local.colorcolumn = "80"

-- Optional: Adjust movement keys to respect visual lines
vim.keymap.set({ "n", "o", "x" }, "j", "gj", { buffer = true }) -- Move down by visual line
vim.keymap.set({ "n", "o", "x" }, "k", "gk", { buffer = true }) -- Move up by visual line
vim.keymap.set({ "n", "o", "x" }, "H", "g0", { buffer = true }) -- Move to start of visual line
vim.keymap.set({ "n", "o", "x" }, "L", "g$", { buffer = true }) -- Move to end of visual line
