return {
	{
		"echasnovski/mini.animate",
		version = false,
		event = "BufEnter",
		config = function()
			require("mini.animate").setup()
		end,
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		opts = {
      draw = {
        delay = 50,
      },
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
}
