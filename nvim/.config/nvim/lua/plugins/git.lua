return {
	{
		"tpope/vim-fugitive",
	},
	{
		"tpope/vim-rhubarb",
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup()
		end,
	},
}
