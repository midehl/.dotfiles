--enable relative line numbers
vim.opt.nu = true
vim.opt.rnu = true

--2 space tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

--enable auto indenting using spaces
vim.opt.smartindent = true
vim.opt.shiftwidth = 2

--enable smart indenting (https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
vim.opt.breakindent = true

--enable incremental searching
vim.opt.incsearch = true
vim.opt.hlsearch = true

--disable text wrap
vim.opt.wrap = false

--set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- better splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

--enable mouse mode
vim.opt.mouse = "a"

--enable ignorecase + smartcase for better searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

--decrease update time
vim.opt.updatetime = 50

--disable auto select in autocmp options
vim.opt.completeopt = { "menuone", "noselect" }

-- persistent undo history
vim.opt.undofile = true

--enable 24-bit colors
vim.opt.termguicolors = true

--enable sign column permanently (prevent screen jump)
vim.opt.signcolumn = "yes"

--enable access to system clipboard
vim.opt.clipboard = "unnamed,unnamedplus"

--enable cursor line highlight
vim.opt.cursorline = true

--enable a column line
--vim.opt.colorcolumn = "80"

-- always keep 8 lines above/below cursor unless at the start/end of file
vim.opt.scrolloff = 8

-- Set fold settings
-- These options were reccommended by nvim-ufo
-- See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

--configure cursor
vim.opt.guicursor = {
	"n-v-c:block", -- block cursor in normal, visual, command
	"i-ci-ve:ver25", --insert, cmd-line insert, visual-exclude: vertical box cursor 25% width
	"r-cr:hor20", --replace, cmd-line replace: horizontal bar cursor 20% height
	"o:hor50", --operator--pending: horizontal bar cursor 50% height
}

-- Map Ctrl+f to tmux-sessionizer
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<C-f>",
-- 	":term $HOME/.local/scripts/tmux-sessionizer<CR>",
-- 	{ noremap = true, silent = true }
-- )
-- TODO: make this work
