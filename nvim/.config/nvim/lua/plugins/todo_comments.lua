return {
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({
				-- changing to catppuccin-mocha colors
				colors = {
					error = { "DiagnosticError", "ErrorMsg", "#F38BA8" },
					warning = { "DiagnosticWarn", "WarningMsg", "#EBA0AC" },
					info = { "DiagnosticInfo", "#B4BEFE" },
					hint = { "DiagnosticHint", "#10B981" },
					default = { "Identifier", "#7C3AED" },
					test = { "Identifier", "#FF00FF" },
				},
			})

			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }
			map("n", "]t", "<cmd>lua require('todo-comments').jump_next()<CR>", opts)
			map("n", "[t", "<cmd>lua require('todo-comments').jump_prev()<CR>", opts)
			map("n", "<leader>xt", "<cmd>TodoTrouble<cr>", opts)
			map("n", "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", opts)
			map("n", "<leader>st", "<cmd>TodoTelescope<cr>", opts)
			map("n", "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", opts)
		end,
	},
}
