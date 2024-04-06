return {
	{
		"echasnovski/mini.animate",
		version = false,
		event = "BufEnter",
		config = function()
			require("mini.animate").setup()
		end,
	},
	--[[ {
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
	} ]]
	{
		"echasnovski/mini.indentscope",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			draw = {
				delay = 50,
			},
			options = { border = "top", try_as_border = true },
			symbol = "▏",
		},
		config = function(_, opts)
			require("mini.indentscope").setup(opts)

			-- Disable for certain filetypes
			vim.api.nvim_create_autocmd({ "FileType" }, {
				desc = "Disable indentscope for certain filetypes",
				callback = function()
					local ignore_filetypes = {
						"aerial",
						"alpha",
						"dashboard",
						"help",
						"lazy",
						"leetcode.nvim",
						"mason",
						"neo-tree",
						"NvimTree",
						"neogitstatus",
						"notify",
						"startify",
						"toggleterm",
						"Trouble",
					}
					if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
						vim.b.miniindentscope_disable = true
					end
				end,
			})
		end,
	},
}
